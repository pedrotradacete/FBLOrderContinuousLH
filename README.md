# FBLOrderContinuousLH

Lean 4 formalization of **Order continuity of induced homomorphisms between free
Banach lattices**, by **Raúl Enrique Pariente-Martín** and **Pedro Tradacete**.

The project proves all **30 numbered results** of the paper's 20 October 2026
version, including the Hilbert-space example in Remark 5.4. It covers order
continuity of induced lattice homomorphisms, the POE operator-extension property,
and order density and majorization for inclusions between different exponents.
All scalar fields are real, and the exponent range includes infinity.

The formalization uses [Mathlib](https://github.com/leanprover-community/mathlib4)
and [BanLat](https://github.com/davidmunozlahoz/banlat).

## Build and verify

Install Lean's toolchain manager [elan](https://github.com/leanprover/elan), then run:

```bash
git clone https://github.com/pedrotradacete/FBLOrderContinuousLH.git
cd FBLOrderContinuousLH
lake exe cache get
lake build
lake env lean scripts/Audit.lean
```

The toolchain and dependencies are pinned in the repository. The final command
runs the proof audit separately from the build: it rejects proof admissions and
any axiom beyond `propext`, `Classical.choice`, and `Quot.sound`.

Verification of these Lean sources on 30 October 2026 found no build warnings or
errors, and the audit passed for all **1,274 project declarations**, including
private and generated helpers.

## Dependencies

| Component | Pinned version |
| --- | --- |
| Lean | `v4.35.0` |
| Mathlib | v4.35.0, commit `56a005855ea17e0b0958f73ec801ae140b0a1679` |
| BanLat | Commit `33c4b73fce845c4295614326193d4e52111be762` |

## Explore the formalization

[FORMALIZATION.md](FORMALIZATION.md) describes the modules, gives a reading order,
and links all 30 paper results to their Lean declarations.

Principal characterizations include:

- [all_parameter_characterization](FBLOrderContinuousLH/Extension.lean#L770):
  order continuity of induced operators for every exponent.
- [poe_inclusion](FBLOrderContinuousLH/Extension.lean#L537):
  the POE characterization for closed-subspace inclusions at finite exponents.
- [cross_parameter_inclusion](FBLOrderContinuousLH/Parameters.lean#L157):
  equivalent conditions for inclusions between different exponents.

The aggregate module loads the entire library:

```lean
import FBLOrderContinuousLH
```

All project declarations are in the namespace `FBLOrderContinuousLH`.

## License

Copyright 2026 FBLOrderContinuousLH contributors.

Licensed under the [Apache License, Version 2.0](LICENSE).
