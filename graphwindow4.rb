=begin
** Form generated from reading ui file 'graphwindow4.ui'
**
** Created: 水 9月 11 17:14:11 2019
**      by: Qt User Interface Compiler version 4.8.7
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_GraphWindowBase
    attr_reader :gridLayout
    attr_reader :graph
    attr_reader :pb_close
    attr_reader :spacerItem

    def setupUi(graphWindowBase)
    if graphWindowBase.objectName.nil?
        graphWindowBase.objectName = "graphWindowBase"
    end
    graphWindowBase.resize(490, 428)
    @gridLayout = Qt::GridLayout.new(graphWindowBase)
    @gridLayout.spacing = 6
    @gridLayout.margin = 9
    @gridLayout.objectName = "gridLayout"
    @graph = Qt::Label.new(graphWindowBase)
    @graph.objectName = "graph"

    @gridLayout.addWidget(@graph, 0, 0, 1, 2)

    @pb_close = Qt::PushButton.new(graphWindowBase)
    @pb_close.objectName = "pb_close"

    @gridLayout.addWidget(@pb_close, 1, 1, 1, 1)

    @spacerItem = Qt::SpacerItem.new(341, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @gridLayout.addItem(@spacerItem, 1, 0, 1, 1)


    retranslateUi(graphWindowBase)
    Qt::Object.connect(@pb_close, SIGNAL('clicked()'), graphWindowBase, SLOT('close()'))

    Qt::MetaObject.connectSlotsByName(graphWindowBase)
    end # setupUi

    def setup_ui(graphWindowBase)
        setupUi(graphWindowBase)
    end

    def retranslateUi(graphWindowBase)
    graphWindowBase.windowTitle = Qt::Application.translate("GraphWindowBase", "Graph Window", nil, Qt::Application::UnicodeUTF8)
    @graph.text = Qt::Application.translate("GraphWindowBase", "TextLabel", nil, Qt::Application::UnicodeUTF8)
    @pb_close.text = Qt::Application.translate("GraphWindowBase", "Close", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(graphWindowBase)
        retranslateUi(graphWindowBase)
    end

end

module Ui
    class GraphWindowBase < Ui_GraphWindowBase
    end
end  # module Ui

