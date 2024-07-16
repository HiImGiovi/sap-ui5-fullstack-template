sap.ui.define(
  ["sap/ui/core/UIComponent", "templateprojectplugin/utils/common"],
  function (UIComponent, common) {
    return UIComponent.extend("templateprojectplugin.Component", {
      metadata: {
        manifest: "json",
      },
      init: async function () {
        // call the base component's init function
        UIComponent.prototype.init.apply(this, arguments);
        await this.addShellPlugin();
      },
      addShellPlugin: async function () {
        const shellRenderer = await common.getUi5Renderer();
        const plugin = await sap.ui.core.Fragment.load({
          name: "templateprojectplugin.fragment.templateprojectplugin",
        });
        this.setManifestComponentModelsToPlugin(plugin);
        shellRenderer.addHeaderEndItem(
          {
            icon: "sap-icon://account",
            press: function (oEvent) {
              const oButton = oEvent.getSource();
              plugin.openBy(oButton);
            },
          },
          true,
          true
        );
      },
      setManifestComponentModelsToPlugin: function (plugin) {
        const componentModels = this.getOwnModels();
        for (const modelName in componentModels) {
          plugin.setModel(componentModels[modelName], modelName);
        }
      },
    });
  }
);
