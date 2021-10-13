## java-web-vue-base
- java-web-vue-base基于vue、element-ui构建开发，后台管理前端功能，提供一套更优的前端解决方案
- 前后端分离，通过token进行数据交互，可独立部署
- 主题定制，通过scss变量统一一站式定制
- 动态菜单，通过菜单管理统一管理访问路由
- 数据切换，通过mock配置对接口数据／mock模拟数据进行切换
- 发布时，可动态配置CDN静态资源／切换新旧版本


cnpm install


cnpm run dev


cnpm run build

## make 打包
    注意：Makefile 文件里 main.go 的路径

    make docker-all VERSION="staging_v0.0.1" ENV_SERVER_MODE="staging"
    make docker-all VERSION="staging_v0.0.1" ENV_SERVER_MODE="dev"
    make docker-all VERSION="prod_v0.0.1" ENV_SERVER_MODE="prod"

    ## 本地编译
    make build-all VERSION="staging_v0.0.1" ENV_SERVER_MODE="staging"
    make build-all VERSION="prod_v0.0.1" ENV_SERVER_MODE="prod"

    docker buildx build --platform linux/amd64 --no-cache -t java-web-vue-base .

    docker build --no-cache -f ./Dockerfile.dev -t java-web-vue-base .
    docker build --no-cache -f ./Dockerfile.pro -t java-web-vue-base .

    docker run --rm --name my-web-base -p 8088:8001 java-web-vue-base:latest

