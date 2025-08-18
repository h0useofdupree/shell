pragma Singleton

import "."
import qs.config
import qs.utils
import Quickshell
import QtQuick

QtObject {
    id: root

    property Searcher searcher: Searcher {
        list: []
        useFuzzy: Config.launcher.useFuzzy.actions
    }

    function query(name, search) {
        const cmd = Config.launcher.commands.find(c => c.name === name);
        if (!cmd || !cmd.submenu.length) {
            searcher.list = [];
            return [];
        }

        const prefix = Config.launcher.actionPrefix;
        const rest = search.slice(`${prefix}${name} `.length);

        searcher.list = cmd.submenu.map(sub => {
            const act = Actions.Action.createObject(searcher);
            act.name = sub.name;
            act.desc = sub.desc ?? "";
            act.icon = sub.icon ?? "";
            act.onClicked = list => {
                list.visibilities.launcher = false;
                Quickshell.execDetached(sub.exec);
            };
            return act;
        });

        return searcher.query(rest);
    }
}
