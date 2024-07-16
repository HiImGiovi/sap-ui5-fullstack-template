sap.ui.define([], function () {
  function getUi5Renderer() {
    return new Promise((resolve, reject) => {
      const oShellContainer = jQuery.sap.getObject("sap.ushell.Container");
      if (!oShellContainer)
        reject(
          "Illegal state: shell container not available; this component must be executed in a unified shell runtime context."
        );
      const oRenderer = oShellContainer.getRenderer();
      if (oRenderer) resolve(oRenderer);
      oShellContainer.attachRendererCreatedEvent((oEvent) => {
        const createdRenderer = oEvent.getParameter("renderer");
        if (!createdRenderer)
          reject(
            "Illegal state: shell renderer not available after receiving 'rendererCreated' event."
          );
        resolve(oRenderer);
      });
    });
  }

  return {
    getUi5Renderer,
  };
});
