const path = require('path');
const folders = ["../", path.resolve(path.join(__dirname, './node_modules'))];
module.exports = {
  transformer: {
    getTransformOptions: async () => ({
      transform: {
        experimentalImportSupport: false,
        inlineRequires: true,
      },
    }),
  },
  resolver: {
    nodeModulesPaths: folders
  },
  watchFolders: folders,
};