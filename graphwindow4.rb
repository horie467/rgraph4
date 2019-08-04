class Ui_GraphWindowBase < Qt::Widget
    attr_reader :qgridLayout
    attr_reader :graph
    attr_reader :pb_close
    attr_reader :spacerItem

    def setupUi(graphWindowBase)
    graphWindowBase.setObjectName("graphWindowBase")
    graphWindowBase.resize(Qt::Size.new(472, 429).expandedTo(graphWindowBase.minimumSizeHint()))
    @qgridLayout = Qt::GridLayout.new(graphWindowBase)
    @qgridLayout.spacing = 6
    @qgridLayout.margin = 9
    @qgridLayout.setObjectName("qgridLayout")
    @graph = Qt::Label.new(graphWindowBase)
    @graph.setObjectName("graph")

    @qgridLayout.addWidget(@graph, 0, 0, 1, 2)

    @pb_close = Qt::PushButton.new(graphWindowBase)
    @pb_close.setObjectName("pb_close")

    @qgridLayout.addWidget(@pb_close, 1, 1, 1, 1)

    @spacerItem = Qt::SpacerItem.new(341, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @qgridLayout.addItem(@spacerItem, 1, 0, 1, 1)

    retranslateUi(graphWindowBase)
    Qt::Object.connect(@pb_close, SIGNAL('clicked()'), graphWindowBase, SLOT('close()'))

    Qt::MetaObject.connectSlotsByName(graphWindowBase)
    end # setupUi

    def retranslateUi(graphWindowBase)
    graphWindowBase.setWindowTitle(Qt::Application.translate("GraphWindowBase", "Graph Window", nil, Qt::Application::UnicodeUTF8))
    @graph.setText(Qt::Application.translate("GraphWindowBase", "TextLabel", nil, Qt::Application::UnicodeUTF8))
    @pb_close.setText(Qt::Application.translate("GraphWindowBase", "Close", nil, Qt::Application::UnicodeUTF8))
    end # retranslateUi

end


