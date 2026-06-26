# メンテナンス

`.agent` コンテナの長期運用時に必要な手順をまとめます。

## DinD のディスク使用量管理

`opencode` サービスは Docker-in-Docker (DinD) 構成のため、コンテナ内で pull / build したイメージやビルドキャッシュが named volume `docker-data` (`/var/lib/docker`) に蓄積されます。長期間運用するとディスクが肥大化するため、定期的にクリーンアップしてください。

### 使用量の確認

```sh
docker compose -f .agent/compose.yaml run --rm opencode docker system df
```

### 未使用リソースのクリーンアップ

未使用のイメージ・コンテナ・ビルドキャッシュを削除:

```sh
docker compose -f .agent/compose.yaml run --rm opencode docker system prune -af
```

### 完全リセット

named volume ごと削除します。次回起動時は全てのイメージが再 pull されます。

```sh
docker volume rm $(docker compose -f .agent/compose.yaml config --volumes)
```
