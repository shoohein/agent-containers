# AIエージェントコンテナ

AIエージェントを Docker Compose 経由で起動するための `.agent` 一式です。
利用先プロジェクトの `.agent` ディレクトリに配置して使います。

## セットアップ

### 必要要件

本ツールを利用するには、以下がインストールされている必要があります。
- Docker
- Docker Compose

### インストール

プロジェクトのルートディレクトリで以下のコマンドを実行します。

```sh
git clone https://github.com/shoohein/agent-containers .agent
```

## 対応ツール一覧

| 対応ツール | サービス名 |
| ---------- | ---------- |
| [OpenCode](https://opencode.ai) | `opencode` |

## 起動方法

プロジェクトのルートディレクトリで以下のコマンドを実行します。

```sh
docker compose -f .agent/compose.yaml run --rm <service_name>
```

※ `<service_name>` には、上の「対応ツール一覧」にあるサービス名を指定してください。

## 更新方法

最新のコンテナ定義を取得するには、以下のコマンドを実行します。

```sh
git -C .agent pull
```

## カスタマイズ（ツールの追加など）

初回起動時に各サービスのディレクトリ（例: `.agent/src/opencode/Dockerfile`）を元にDockerイメージがビルドされます。

プロジェクト固有で必要なパッケージやツールがある場合は、事前に対象サービスの `Dockerfile` にインストール手順を追記してから起動してください。
※Dockerfileを編集した場合は、`docker compose -f .agent/compose.yaml build <service_name>` でイメージの再ビルドが必要です。

## 環境変数

※ 相対パスは `.agent` ディレクトリ（`compose.yaml` の配置場所）を基準に解決されます。

- `AGENT_IMAGE_PREFIX`: イメージのプレフィックス。既定値は `agent`。最終的な image 名は `<prefix>/<service_name>`
- `WORKSPACE`: `/workspaces/main` に bind mount するホスト側ディレクトリ。既定値は `..`（プロジェクトのルートディレクトリ）
- `AGENT_HOME`: `/home/agent` に bind mount するホスト側ディレクトリ。既定値は `./agent-home`（`.agent/agent-home` ディレクトリ）
- `TZ`: 既定値は `Asia/Tokyo`
- `TERM`: 既定値は `xterm-256color`
- `COLORTERM`: 既定値は `truecolor`

### OpenCode固有

- `OPENCODE_CONFIG_DIR`: `/opencode_config` に bind mount するホスト側ディレクトリ。既定値は `./.opencode`
