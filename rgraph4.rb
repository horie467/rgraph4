#!/usr/bin/env ruby
# frozen_string_literal: true
# git version

# rgraph for qtruby4
# for linux and windows
require 'Qt'
require './graphpanel4.rb'
require './graphwindow4.rb'
include Math

class GraphData
  attr_accessor :xmin, :xmax, :ymin, :ymax, :func_y
  def initialize
    @xmin = -1
    @xmax = 1
    @ymin = -1
    @ymax = 1
    @func_y = 'sin(x)'
  end
end

class GraphPanel < Ui_GraphPanelBase
  # slots 'draw_graph()'
  def initialize(w)
    @graphPanelWidget = w
    super()
    setupUi(w)
    @graph_data = GraphData.new

    @xmax.setText(@graph_data.xmax.to_s)
    @xmin.setText(@graph_data.xmin.to_s)
    @ymax.setText(@graph_data.ymax.to_s)
    @ymin.setText(@graph_data.ymin.to_s)
    @le_func.setText(@graph_data.func_y.to_s)

    # @gwin = GraphWindow.new(w)
    # @gwin.show
    # @gwin.clear
    Qt::Object.connect(@pb_draw, SIGNAL('clicked()'), @graphPanelWidget, SLOT('draw_graph()'))

    w.setGraphPanel(self)
  end

  def setGraphWindow(gwin)
    @gwin = gwin
    @gwin.clear
  end

  def draw_graph
    puts 'draw_graph in GraphPanel called'
    get_parameters
    @gwin.set_graph_data(@graph_data)
    @gwin.draw
    # @graphPanelWidget.show
    @gwin.setup = true
  end

  def get_parameters
    @graph_data.xmax = @xmax.text.to_str.to_f
    @graph_data.xmin = @xmin.text.to_str.to_f
    @graph_data.ymax = @ymax.text.to_str.to_f
    @graph_data.ymin = @ymin.text.to_str.to_f
    @graph_data.func_y = @le_func.text.to_str
  end

  def get_graph_data
    @graph_data
  end
end

class GraphWindow < Ui_GraphWindowBase
  attr_accessor :setup, :frame_margin_x, :frame_margin_y
  def initialize(w, gdata = nil)
    super()
    setupUi(w)
    @graphWindowWidget = w
    @gdata = gdata
    # @graphWindowWidget.resize(400,400)
    @graph.resize(400, 400)
    @painter = Qt::Painter.new

    @setup = false
    @frame_margin_x = 10
    @frame_margin_y = 10
    @margin_x = 50
    @margin_left = 50
    @margin_y = 50
    @graph_res = 1000
    @logical_w = @graph_res + (@margin_x * 2) + @margin_left
    @logical_h = @graph_res + (@margin_y * 2)

    w.setGraphWindow(self)
    end

  def clear
    @pixmap = Qt::Pixmap.new(@graph.size)
    @pixmap.fill
    @graph.setPixmap(@pixmap)
  end

  def draw
    @setup = false
    @pixmap = Qt::Pixmap.new(@graph.size)
    @pixmap.fill
    drawGraph
    drawAxis
    @setup = true
    @graph.setPixmap(@pixmap)
    @graphWindowWidget.show
  end

  def set_graph_data(gdata)
    @graph_data = gdata
  end

  def trX(x)
    ((x - @graph_data.xmin) / (@graph_data.xmax - @graph_data.xmin) * @graph_res.to_f + @margin_x + @margin_left).to_i
  end

  def trY(y)
    y = @graph_data.ymax > y ? y : @graph_data.ymax
    y = @graph_data.ymin < y ? y : @graph_data.ymin
    ((@graph_data.ymax - y) / (@graph_data.ymax - @graph_data.ymin) * @graph_res.to_f + @margin_y).to_i
  end

  def drawGraph
    @painter.begin(@pixmap)
    @painter.setPen(Qt.black)
    @painter.setWindow(0, 0, @logical_w, @logical_h)
    @painter.drawLine(trX(@graph_data.xmin), trY(0), trX(@graph_data.xmax), trY(0))
    @painter.drawLine(trX(0), trY(@graph_data.ymin), trX(0), trY(@graph_data.ymax))
    x = @graph_data.xmin
    y = eval(@graph_data.func_y)
    delta = (@graph_data.xmax - @graph_data.xmin) / @graph_res.to_f
    while x < @graph_data.xmax
      xold = x
      yold = y
      x += delta
      y = eval(@graph_data.func_y)

      @painter.drawLine(trX(xold), trY(yold), trX(x), trY(y))
    end
    @painter.end
    end

  def drawAxis
    @painter.begin(@pixmap)
    @painter.setPen(Qt.black)
    @painter.setWindow(0, 0, @logical_w, @logical_h)
    @painter.drawRect(trX(@graph_data.xmin), trY(@graph_data.ymax), trX(@graph_data.xmax) - trX(@graph_data.xmin), trY(@graph_data.ymin) - trY(@graph_data.ymax))
    x_interval = (@graph_data.xmax - @graph_data.xmin) / 10.0
    y_interval = (@graph_data.ymax - @graph_data.ymin) / 10.0
    x_mark = 20 # / @logical_w * @Graph.width
    y_mark = 20 # / @logical_h * @Graph.height
    qfont = Qt::Font.new('Helvetica')
    qfont.setPixelSize(30)
    @painter.setFont(qfont)
    (1..9).each do |i|
      x = i * x_interval + @graph_data.xmin
      y = i * y_interval + @graph_data.ymin
      @painter.drawLine(trX(x), trY(@graph_data.ymin), trX(x), (trY(@graph_data.ymin) - y_mark))
      @painter.drawText((trX(x) - x_mark).to_i, (trY(@graph_data.ymin) + y_mark * 2).to_i, format('%#.02g', x))
      @painter.drawLine(trX(@graph_data.xmin), trY(y), (trX(@graph_data.xmin) + x_mark), trY(y))
      @painter.drawText((trX(@graph_data.xmin) - x_mark * 4).to_i, trY(y).to_i, format('%#.02g', y))
    end
    @painter.end
    end
end

class GraphPanelWidget < Qt::Widget
  slots 'draw_graph()'
  def setGraphPanel(gp)
    @graphPanel = gp
  end

  def draw_graph
    puts 'draw_graph called'
    @graphPanel.draw_graph
  end

  def setGraphWindowWidget(w)
    @gwin = w
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
    ret = Qt::MessageBox.warning(
      self,
      'Close Windows?',
      'Close all windows ?',
      Qt::MessageBox::Yes,
      Qt::MessageBox::No
    )
    ret != Qt::MessageBox::No
  end
end

class GraphWindowWidget < Qt::Widget
  def setGraphWindow(gw)
    @gw = gw
  end

  def resizeEvent(_e)
    @gw.graph.setGeometry(@gw.frame_margin_x, @gw.frame_margin_y, width - (@gw.frame_margin_x * 2), height - 70)
    @gw.draw if @gw.setup
  end
end

a = Qt::Application.new(ARGV)
w = GraphWindowWidget.new
p = GraphPanelWidget.new

gw = GraphWindow.new(w)
gp = GraphPanel.new(p)

gp.setGraphWindow(gw)
p.setGraphWindowWidget(w)

w.show
p.show

a.exec
