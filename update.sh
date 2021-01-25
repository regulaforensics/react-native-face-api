# Example
# sh ./update.sh react/react-native-document-reader-api/ Release  Release + + Beta +
#1) path to module
#2) ios api branch(Beta or Release)
#3) android api branch(Beta or Release)
#4) ios api version
#5) android api version
#6) module branch(beta or release, if beta, module name will be changed to react-native-document-reader-api-beta in package.json)
#7) module version
#8) core module branch for sample inside of api module(beta or release, 
#   if beta, core module name will be changed to @regulaforensics/react-native-document-reader-core-fullrfid-beta in example/package.json)
#9) core module version
# Base_path=$1
# Branch_ios=$2
# Branch_android=$3
# Version_ios=$4
# Version_android=$5
# Destination_type=$6
# React_module_version=$7
# Core_module_type=$8
# Core_module_version=$9
# PODS_URL_RELEASE='https://pods.regulaforensics.com/DocumentReader/'
# PODS_URL_BETA='https://pods.regulaforensics.com/DocumentReaderBeta/'
# MAVEN_URL_RELEASE='http://maven.regulaforensics.com/RegulaDocumentReader/com/regula/documentreader/api/'
# MAVEN_URL_BETA='http://maven.regulaforensics.com/RegulaDocumentReader/Beta/com/regula/documentreader/api/'
# if [ "$Branch_ios" == 'Beta' ]; then
#     STATE_IOS='Beta'
#     URL_IOS=$PODS_URL_BETA
# else
# 	if [ "$Branch_ios" == 'Release' ]; then
# 		STATE_IOS=''
# 		URL_IOS=$PODS_URL_RELEASE
# 	else
# 		echo "Incorrect ios type(must be Beta or Release)"
#         rm -rf "$Base_path/../../react-native-document-reader-api"
# 		exit 1
# 	fi
# fi
# if [ "$Branch_android" == 'Beta' ]; then
#     URL_ANDROID=$MAVEN_URL_BETA
# else
# 	if [ "$Branch_android" == 'Release' ]; then
# 		URL_ANDROID=$MAVEN_URL_RELEASE
# 	else
# 		echo "Incorrect android type(must be Beta or Release)"
#         rm -rf "$Base_path/../../react-native-document-reader-api"
# 		exit 1
# 	fi
# fi
# if [ "$Destination_type" == 'Beta' ]; then
#     DEST_TYPE='-beta'
#     GITHUB_BRANCH='develop'
# else
# 	if [ "$Destination_type" == 'Release' ]; then
# 		DEST_TYPE=''
#         GITHUB_BRANCH='master'
# 	else
# 		echo "Incorrect destination type(must be Beta or Release)"
#         rm -rf "$Base_path/../../react-native-document-reader-api"
# 		exit 1
# 	fi
# fi 

# if [ "$Core_module_type" == 'Beta' ]; then
#     CORE_TYPE='-beta'
# else
# 	if [ "$Core_module_type" == 'Release' ]; then
# 		CORE_TYPE=''
# 	else
# 		echo "Incorrect destination type(must be Beta or Release)"
# 		rm -rf "$Base_path/../../react-native-document-reader-api"
# 	    exit 1
# 	fi
# fi

# PKG_NAME="@regulaforensics/react-native-document-reader-api$DEST_TYPE"
# CORE_PKG_NAME="@regulaforensics/react-native-document-reader-core-fullrfid$CORE_TYPE"
# PKG_NAME_CLEAN="react-native-document-reader-api$DEST_TYPE"
# CORE_PKG_NAME_CLEAN="react-native-document-reader-core-fullrfid$CORE_TYPE"
# if [ "$React_module_version" == '+' ]; then
# 	LatestModuleVersion="$(sudo npm view $PKG_NAME version)"
# 	React_module_version="${LatestModuleVersion%.*}.$((${LatestModuleVersion##*.}+1))"
# fi
# if [ "$React_module_version" == '.1' ]; then
# 	React_module_version='0.0.1'
#     ModuleIsNew='(new)'
# fi
# if [ "$Core_module_version" == '+' ]; then
# 	Core_module_version="$(sudo npm view $CORE_PKG_NAME version)"
# fi
# if [ "$Core_module_version" == '.1' ]; then
# 	echo "No core module found: $CORE_PKG_NAME"
# 	rm -rf "$Base_path/../../react-native-document-reader-api"
# 	exit 1
# fi
# if [ "$Version_ios" == '+' ]; then
#     /usr/local/bin/wget -O index.html "$URL_IOS"
#     if [[ $? -ne 0 ]]; then
#         echo "Failed on wget call for $URL_IOS"
#         rm -rf "$Base_path/../../react-native-document-reader-api"
#         exit 1
#     fi
#     size=$(xmllint --html -xpath "count(//a)" index.html)
#     count=$(( size - 2 ))
#     v=$(xmllint --html -xpath "//html/body/table/tr[$count]/td[2]/a/text()" index.html)
#     Version_ios=${v:0:${#v}-1}
#     rm index.html
# fi
# if [ "$Version_android" == '+' ]; then
#     MAVEN_MATADATA="$URL_ANDROID/maven-metadata.xml"
#     /usr/local/bin/wget -O maven-metadata.xml $MAVEN_MATADATA
#     if [[ $? -ne 0 ]]; then
#         echo "Failed on wget call for $MAVEN_MATADATA"
#         rm -rf "$Base_path/../../react-native-document-reader-api"
#         exit 1
#     fi
#     Version_android=$(xmllint --xpath 'string(//metadata/versioning/release)' maven-metadata.xml)
#     rm maven-metadata.xml
# fi

# if ! curl --output /dev/null --silent --head --fail "$URL_ANDROID$Version_android/api-$Version_android.aar"
# then
#     echo "Invalid URL for android: $URL_ANDROID$Version_android/api-$Version_android.aar"
#     rm -rf "$Base_path/../../react-native-document-reader-api"
#     exit 1
# fi

# sed -i -e "s/version_place_holder/$Version_android/" "$Base_path/android/build.gradle"
# rm -fr "$Base_path/android/build.gradle-e"

# if ! curl --output /dev/null --silent --head --fail "$URL_IOS$Version_ios/DocumentReader$STATE_IOS-$Version_ios.zip"
# then
#     echo "Invalid URL for ios: $URL_IOS$Version_ios/DocumentReader$STATE_IOS-$Version_ios.zip"
#     rm -rf "$Base_path/../../react-native-document-reader-api"
#     exit 1
# fi

# cd "$Base_path"
# sed -i -e "s/version_place_holder/$Version_ios/" "$Base_path/RNDocumentReaderApi.podspec"
# sed -i -e "s/branch_place_holder/$STATE_IOS/" "$Base_path/RNDocumentReaderApi.podspec"
# rm -fr "$Base_path/RNDocumentReaderApi.podspec-e"
# /usr/local/bin/jq --arg PKG_NAME "$PKG_NAME" '.name = $PKG_NAME' package.json > tmp.$$.json && mv tmp.$$.json package.json
# /usr/local/bin/jq --arg React_module_version "$React_module_version" '.version = $React_module_version' package.json > tmp.$$.json && mv tmp.$$.json package.json


# sed -i -e "s/api_module_place_holder/$PKG_NAME_CLEAN/" "$Base_path/example/package.json"
# sed -i -e "s/api_version_place_holder/$React_module_version/" "$Base_path/example/package.json"
# sed -i -e "s/core_module_place_holder/$CORE_PKG_NAME_CLEAN/" "$Base_path/example/package.json"
# sed -i -e "s/core_version_place_holder/$Core_module_version/" "$Base_path/example/package.json"
# rm -fr "$Base_path/example/package.json-e"

# sed -i -e "s/api_module_place_holder/$PKG_NAME_CLEAN/" "$Base_path/example/App.js"
# rm -fr "$Base_path/example/App.js-e"

# if sudo /usr/local/bin/npm publish ; then
#     echo ''
#     echo 'SUCCESS!'
#     echo ''
#     echo "Android: $Branch_android $Version_android"
#     echo "IOS: $Branch_ios $Version_ios"
#     echo "Module: $Destination_type $React_module_version$ModuleIsNew"
#     echo "Core module(in example): $CORE_PKG_NAME $Core_module_version"
#     echo ''
# else
#     echo "npm publish failed"
#     rm -rf "$Base_path/../../react-native-document-reader-api"
# 	exit 1
# fi

# echo ""
# echo "Pushing to github"
# echo ""

# cd "$Base_path"
# cd "../"
# git clone --branch "$GITHUB_BRANCH" https://github.com/regulaforensics/react-native-document-reader.git react_temp_dir
# cp -rf "$Base_path/../react_temp_dir/.git" "$Base_path/.git"
# rm -rf "$Base_path/../react_temp_dir"
# mkdir "$Base_path/../react_temp_dir"
# cp -rf "$Base_path/." "$Base_path/../react_temp_dir"

# cd "$Base_path/../react_temp_dir"
# git stage --all
# git commit --message "$React_module_version"
# if git push ; then
#     rm -rf "$Base_path/../react_temp_dir"
#     echo ""
#     echo "SUCCESS!"
#     echo ""
# else
#     echo ""
#     echo "Push failed"
#     echo "Now plugin version on npmjs.com is higher than on github"
#     echo "This may cause a build fail"
#     echo "Next successful script run will fix the issue"
#     echo ""
#     rm -rf "$Base_path/../../react-native-document-reader-api"
#     rm -rf "$Base_path/../react_temp_dir"
# 	exit 1
# fi

# rm -rf "$Base_path/../react_temp_dir"
# rm -rf "$Base_path/../../react-native-document-reader-api"
