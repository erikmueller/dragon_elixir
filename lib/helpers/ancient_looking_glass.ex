defmodule Helpers.AncientLookingGlass do
    import Record, only: [defrecord: 2, extract: 2]

    defrecord :xmlElement, extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
    defrecord :xmlText, extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")
end
