> [!WARNING]
> **Projet personnel « vibecodé ».** Cette source et ses tweaks ont été écrits par **Claude** (Anthropic, via Claude Code), à la demande spécifique de [@NOxygen59](https://github.com/NOxygen59), pour **son appareil précis** :
>
> **iPad Pro 12,9" 5ᵉ génération (puce M1) — 512 Go de stockage, 8 Go de RAM — iOS 16.6.1, jailbreak Dopamine (rootless) + TrollStore.**
>
> Rien n'est testé ni prévu pour un autre appareil. Pas de support.

# Source Sileo de NOxygen59

Une source de paquets (dépôt APT) pour Sileo, hébergée gratuitement par GitHub Pages :

```text
https://noxygen59.github.io/sileo-repo/
```

Sur l'iPad, ouvrir [sileo://source/https://noxygen59.github.io/sileo-repo/](sileo://source/https://noxygen59.github.io/sileo-repo/), ou dans Sileo : **Sources › Modifier › +**, puis coller l'adresse.

| Paquet | Dépôt du code |
|---|---|
| Arrow, Finally. Revamped | [arrow-finally-Revamped](https://github.com/NOxygen59/arrow-finally-Revamped) |
| Dual Wield Pad | [dual-wield-pad](https://github.com/NOxygen59/dual-wield-pad) |
| iOS MCP (fork en français) | [ios-mcp](https://github.com/NOxygen59/ios-mcp) |

## Comment ça marche

1. Les paquets `.deb` sont dans [`debs/`](debs).
2. À chaque push, l'action [Publier la source Sileo](.github/workflows/pages.yml) lance `scripts/build-index.sh`. Le script génère `Packages` (avec ses versions compressées) et `Release` (avec leurs sommes de contrôle), puis publie le tout sur GitHub Pages.
3. Sileo relit `Release` et `Packages` à chaque actualisation, et propose les nouvelles versions.

**Publier une mise à jour :** déposer le nouveau `.deb` dans `debs/` et pousser. Pour Arrow et iOS MCP, `scripts/publish.sh` du dépôt du tweak fait tout : compilation, copie et push. L'ancienne version peut rester, Sileo prend la plus récente.

Pour tester l'index sur un Mac : `brew install dpkg`, puis `scripts/build-index.sh _site`.

## Licence

Les scripts et la page de cette source sont sous licence **MIT**. Chaque paquet garde la licence de son propre dépôt.
