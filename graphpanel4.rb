class Ui_GraphPanelBase < Qt::Widget
    attr_reader :qgridLayout
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
    graphPanelBase.setObjectName("graphPanelBase")
    graphPanelBase.resize(Qt::Size.new(360, 164).expandedTo(graphPanelBase.minimumSizeHint()))
    @qgridLayout = Qt::GridLayout.new(graphPanelBase)
    @qgridLayout.spacing = 6
    @qgridLayout.margin = 9
    @qgridLayout.setObjectName("qgridLayout")
    @textLabel1 = Qt::Label.new(graphPanelBase)
    @textLabel1.setObjectName("textLabel1")

    @qgridLayout.addWidget(@textLabel1, 0, 0, 1, 1)

    @ymax = Qt::LineEdit.new(graphPanelBase)
    @ymax.setObjectName("ymax")

    @qgridLayout.addWidget(@ymax, 2, 2, 1, 1)

    @ymin = Qt::LineEdit.new(graphPanelBase)
    @ymin.setObjectName("ymin")

    @qgridLayout.addWidget(@ymin, 2, 1, 1, 1)

    @xmin = Qt::LineEdit.new(graphPanelBase)
    @xmin.setObjectName("xmin")

    @qgridLayout.addWidget(@xmin, 1, 1, 1, 1)

    @xmax = Qt::LineEdit.new(graphPanelBase)
    @xmax.setObjectName("xmax")

    @qgridLayout.addWidget(@xmax, 1, 2, 1, 1)

    @pb_draw = Qt::PushButton.new(graphPanelBase)
    @pb_draw.setObjectName("pb_draw")

    @qgridLayout.addWidget(@pb_draw, 3, 0, 1, 2)

    @textLabel3 = Qt::Label.new(graphPanelBase)
    @textLabel3.setObjectName("textLabel3")

    @qgridLayout.addWidget(@textLabel3, 2, 0, 1, 1)

    @pb_close = Qt::PushButton.new(graphPanelBase)
    @pb_close.setObjectName("pb_close")

    @qgridLayout.addWidget(@pb_close, 3, 2, 1, 1)

    @textLabel2 = Qt::Label.new(graphPanelBase)
    @textLabel2.setObjectName("textLabel2")

    @qgridLayout.addWidget(@textLabel2, 1, 0, 1, 1)

    @le_func = Qt::LineEdit.new(graphPanelBase)
    @le_func.setObjectName("le_func")

    @qgridLayout.addWidget(@le_func, 0, 1, 1, 2)

    retranslateUi(graphPanelBase)
    Qt::Object.connect(@pb_close, SIGNAL('clicked()'), graphPanelBase, SLOT('close()'))

    Qt::MetaObject.connectSlotsByName(graphPanelBase)
    end # setupUi

    def retranslateUi(graphPanelBase)
    graphPanelBase.setWindowTitle(Qt::Application.translate("GraphPanelBase", "Graph Settings", nil, Qt::Application::UnicodeUTF8))
    @textLabel1.setText(Qt::Application.translate("GraphPanelBase", "y=", nil, Qt::Application::UnicodeUTF8))
    @pb_draw.setText(Qt::Application.translate("GraphPanelBase", "Draw", nil, Qt::Application::UnicodeUTF8))
    @textLabel3.setText(Qt::Application.translate("GraphPanelBase", "Y range:", nil, Qt::Application::UnicodeUTF8))
    @pb_close.setText(Qt::Application.translate("GraphPanelBase", "Close", nil, Qt::Application::UnicodeUTF8))
    @textLabel2.setText(Qt::Application.translate("GraphPanelBase", "X range:", nil, Qt::Application::UnicodeUTF8))
    end # retranslateUi

end


