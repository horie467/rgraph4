=begin
** Form generated from reading ui file 'graphpanel4.ui'
**
** Created: 土 9月 21 11:00:53 2019
**      by: Qt User Interface Compiler version 4.8.7
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_GraphPanelBase
    attr_reader :gridLayout
    attr_reader :textLabel1
    attr_reader :ymax
    attr_reader :ymin
    attr_reader :xmin
    attr_reader :xmax
    attr_reader :pb_draw
    attr_reader :textLabel3
    attr_reader :pb_close
    attr_reader :textLabel2
    attr_reader :le_func

    def setupUi(graphPanelBase)
    if graphPanelBase.objectName.nil?
        graphPanelBase.objectName = "graphPanelBase"
    end
    graphPanelBase.resize(360, 166)
    @gridLayout = Qt::GridLayout.new(graphPanelBase)
    @gridLayout.spacing = 6
    @gridLayout.margin = 9
    @gridLayout.objectName = "gridLayout"
    @textLabel1 = Qt::Label.new(graphPanelBase)
    @textLabel1.objectName = "textLabel1"

    @gridLayout.addWidget(@textLabel1, 0, 0, 1, 1)

    @ymax = Qt::LineEdit.new(graphPanelBase)
    @ymax.objectName = "ymax"

    @gridLayout.addWidget(@ymax, 2, 2, 1, 1)

    @ymin = Qt::LineEdit.new(graphPanelBase)
    @ymin.objectName = "ymin"

    @gridLayout.addWidget(@ymin, 2, 1, 1, 1)

    @xmin = Qt::LineEdit.new(graphPanelBase)
    @xmin.objectName = "xmin"

    @gridLayout.addWidget(@xmin, 1, 1, 1, 1)

    @xmax = Qt::LineEdit.new(graphPanelBase)
    @xmax.objectName = "xmax"

    @gridLayout.addWidget(@xmax, 1, 2, 1, 1)

    @pb_draw = Qt::PushButton.new(graphPanelBase)
    @pb_draw.objectName = "pb_draw"

    @gridLayout.addWidget(@pb_draw, 3, 0, 1, 2)

    @textLabel3 = Qt::Label.new(graphPanelBase)
    @textLabel3.objectName = "textLabel3"

    @gridLayout.addWidget(@textLabel3, 2, 0, 1, 1)

    @pb_close = Qt::PushButton.new(graphPanelBase)
    @pb_close.objectName = "pb_close"

    @gridLayout.addWidget(@pb_close, 3, 2, 1, 1)

    @textLabel2 = Qt::Label.new(graphPanelBase)
    @textLabel2.objectName = "textLabel2"

    @gridLayout.addWidget(@textLabel2, 1, 0, 1, 1)

    @le_func = Qt::LineEdit.new(graphPanelBase)
    @le_func.objectName = "le_func"

    @gridLayout.addWidget(@le_func, 0, 1, 1, 2)


    retranslateUi(graphPanelBase)
    Qt::Object.connect(@pb_close, SIGNAL('clicked()'), graphPanelBase, SLOT('close()'))

    Qt::MetaObject.connectSlotsByName(graphPanelBase)
    end # setupUi

    def setup_ui(graphPanelBase)
        setupUi(graphPanelBase)
    end

    def retranslateUi(graphPanelBase)
    graphPanelBase.windowTitle = Qt::Application.translate("GraphPanelBase", "Graph Settings", nil, Qt::Application::UnicodeUTF8)
    @textLabel1.text = Qt::Application.translate("GraphPanelBase", "y=", nil, Qt::Application::UnicodeUTF8)
    @pb_draw.text = Qt::Application.translate("GraphPanelBase", "Draw", nil, Qt::Application::UnicodeUTF8)
    @textLabel3.text = Qt::Application.translate("GraphPanelBase", "Y range:", nil, Qt::Application::UnicodeUTF8)
    @pb_close.text = Qt::Application.translate("GraphPanelBase", "Close", nil, Qt::Application::UnicodeUTF8)
    @textLabel2.text = Qt::Application.translate("GraphPanelBase", "X range:", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(graphPanelBase)
        retranslateUi(graphPanelBase)
    end

end

module Ui
    class GraphPanelBase < Ui_GraphPanelBase
    end
end  # module Ui

