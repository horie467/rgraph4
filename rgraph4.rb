#!/usr/bin/ruby
#rgraph for qtruby4
require "Qt"
require ".\\graphpanel4.rb"
require ".\\graphwindow4.rb"
include Math

class GraphData
attr_accessor:xmin,:xmax,:ymin,:ymax,:func_y
def initialize
  @xmin=-1
  @xmax=1
  @ymin=-1
  @ymax=1
  @func_y="sin(x)"
end
end

class GraphPanel < Ui_GraphPanelBase
slots 'draw_graph()'
def initialize
  super
  setupUi(self)
  @graph_data=GraphData.new

  @xmax.setText(@graph_data.xmax.to_s)
  @xmin.setText(@graph_data.xmin.to_s)
  @ymax.setText(@graph_data.ymax.to_s)
  @ymin.setText(@graph_data.ymin.to_s)
  @le_func.setText(@graph_data.func_y.to_s)

  @gwin = GraphWindow.new()
  @gwin.show
  @gwin.clear
  connect(@pb_draw,SIGNAL('clicked()'),self,SLOT('draw_graph()'))
end
def draw_graph()
  get_parameters
  @gwin.set_graph_data(@graph_data)
  @gwin.show
  @gwin.draw
  @gwin.setup=true
end

def get_parameters
  @graph_data.xmax=@xmax.text.to_str.to_f
  @graph_data.xmin=@xmin.text.to_str.to_f
  @graph_data.ymax=@ymax.text.to_str.to_f
  @graph_data.ymin=@ymin.text.to_str.to_f
  @graph_data.func_y = @le_func.text.to_str
end

def get_graph_data
  @graph_data
end

    def closeEvent(e)
       if confirmExit
           @gwin.close
           e.accept
       else
           e.ignore
        end
    end

    def confirmExit
        ret = 0
        ret = Qt::MessageBox::warning(
                                self,
                                "Close Windows?" ,
                                "Close all windows ?",
                                 Qt::MessageBox::Yes,
                                 Qt::MessageBox::No)
        return ret != Qt::MessageBox::No
    end


end

class GraphWindow < Ui_GraphWindowBase
attr_accessor :setup
def initialize(gdata=nil)
  super()
  setupUi(self)
  @gdata = gdata
  resize(400,400)
  @painter = Qt::Painter.new

  @setup = false
  @frame_margin_x=10
  @frame_margin_y=10
  @margin_x=50
  @margin_left=50
  @margin_y=50
  @graph_res=1000
  @logical_w=@graph_res + (@margin_x * 2)+ @margin_left
  @logical_h=@graph_res + (@margin_y * 2)

end

def clear()
  @pixmap = Qt::Pixmap.new(@graph.size)
  @pixmap.fill()
  @graph.setPixmap(@pixmap)
end
def draw()
  @setup = false
  @pixmap = Qt::Pixmap.new(@graph.size)
  @pixmap.fill()
  drawGraph
  drawAxis
  @setup = true
  @graph.setPixmap(@pixmap)
end

def set_graph_data(gdata)
  @graph_data = gdata
end
def trX(x)
  ((x - @graph_data.xmin) / (@graph_data.xmax - @graph_data.xmin) * @graph_res.to_f + @margin_x + @margin_left).to_i
end
def trY(y)
   y = @graph_data.ymax > y ? y:@graph_data.ymax
   y = @graph_data.ymin < y ? y:@graph_data.ymin
  ((@graph_data.ymax - y) / (@graph_data.ymax - @graph_data.ymin) * @graph_res.to_f + @margin_y).to_i
end

def drawGraph
  @painter.begin(@pixmap)
  @painter.setPen(Qt::black)
  @painter.setWindow(0,0,@logical_w,@logical_h)
  @painter.drawLine(trX(@graph_data.xmin),trY(0),trX(@graph_data.xmax),trY(0))
  @painter.drawLine(trX(0),trY(@graph_data.ymin),trX(0),trY(@graph_data.ymax))
  x = @graph_data.xmin
  y = eval(@graph_data.func_y)
  delta = (@graph_data.xmax - @graph_data.xmin ) / @graph_res.to_f
  while(x < @graph_data.xmax) do
    xold = x
    yold = y
    x = x + delta
    y = eval(@graph_data.func_y)

    @painter.drawLine(trX(xold),trY(yold),trX(x),trY(y))
  end
  @painter.end()

end

def drawAxis
  @painter.begin(@pixmap)
  @painter.setPen(Qt::black)
  @painter.setWindow(0,0,@logical_w,@logical_h)
  @painter.drawRect(trX(@graph_data.xmin),trY(@graph_data.ymax),trX(@graph_data.xmax)-trX(@graph_data.xmin),trY(@graph_data.ymin)-trY(@graph_data.ymax))
  x_interval = (@graph_data.xmax - @graph_data.xmin) / 10.0
  y_interval = (@graph_data.ymax - @graph_data.ymin) / 10.0
  x_mark = 20 #/ @logical_w * @Graph.width
  y_mark = 20 #/ @logical_h * @Graph.height
  qfont = Qt::Font.new("Helvetica")
  qfont.setPixelSize(30)
  @painter.setFont(qfont)
  for i in 1..9 
    x = i * x_interval + @graph_data.xmin
    y = i * y_interval + @graph_data.ymin
    @painter.drawLine(trX(x),trY(@graph_data.ymin),trX(x),(trY(@graph_data.ymin) - y_mark))
    @painter.drawText((trX(x) - x_mark).to_i,(trY(@graph_data.ymin) + y_mark * 2).to_i,sprintf("%#.02g",x))
    @painter.drawLine(trX(@graph_data.xmin),trY(y),(trX(@graph_data.xmin) + x_mark),trY(y))
    @painter.drawText((trX(@graph_data.xmin) - x_mark * 4).to_i,trY(y).to_i,sprintf("%#.02g",y))
  end
  @painter.end()

end

def resizeEvent(e)
@graph.setGeometry(@frame_margin_x,@frame_margin_y,width()-(@frame_margin_x * 2),height()-70)
  if(@setup)
    draw
  end
end

end

a = Qt::Application.new(ARGV)
main = GraphPanel.new
main.show
a.exec


