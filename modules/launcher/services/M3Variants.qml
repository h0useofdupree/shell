pragma Singleton

import ".."
import qs.config
import qs.utils
import Quickshell
import QtQuick

Searcher {
    id: root

    function transformSearch(search: string): string {
        return search.slice(`${Config.launcher.actionPrefix}variant `.length);
    }

    list: [
        Variant {
            variant: "vibrant"
            icon: "sentiment_very_dissatisfied"
            name: "Vibrant"
            description: "A high chroma palette. The primary palette's chroma is at maximum."
        },
        Variant {
            variant: "tonalspot"
            icon: "android"
            name: "Tonal Spot"
            description: "Default for Material theme colours. A pastel palette with a low chroma."
        },
        Variant {
            variant: "expressive"
            icon: "compare_arrows"
            name: "Expressive"
            description: "A medium chroma palette. The primary palette's hue is different from the seed colour, for variety."
        },
        Variant {
            variant: "fidelity"
            icon: "compare"
            name: "Fidelity"
            description: "Matches the seed colour, even if the seed colour is very bright (high chroma)."
        },
        Variant {
            variant: "content"
            icon: "sentiment_calm"
            name: "Content"
            description: "Almost identical to fidelity."
        },
        Variant {
            variant: "fruitsalad"
            icon: "nutrition"
            name: "Fruit Salad"
            description: "A playful theme - the seed colour's hue does not appear in the theme."
        },
        Variant {
            variant: "rainbow"
            icon: "looks"
            name: "Rainbow"
            description: "A playful theme - the seed colour's hue does not appear in the theme."
        },
        Variant {
            variant: "neutral"
            icon: "contrast"
            name: "Neutral"
            description: "Close to grayscale, a hint of chroma."
        },
        Variant {
            variant: "monochrome"
            icon: "filter_b_and_w"
            name: "Monochrome"
            description: "All colours are grayscale, no chroma."
        }
    ]
    useFuzzy: Config.launcher.useFuzzy.variants

    component Variant: QtObject {
        required property string variant
        required property string icon
        required property string name
        required property string description

        function onClicked(list: AppList): void {
            list.visibilities.launcher = false;
            Quickshell.execDetached(["caelestia", "scheme", "set", "-v", variant]);
        }
    }
}
