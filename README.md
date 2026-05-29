# Conservation Spectral SDK — FORTRAN IV (1960s Style)

A spectral analysis library for conservation metrics, written in authentic 1960s-era FORTRAN IV.

## Routines

| Routine | File | Description |
|---------|------|-------------|
| `SPLAPL` | `splapl.f` | Build combinatorial Laplacian from adjacency/transition matrix |
| `SPJACB` | `spjacb.f` | Jacobi eigendecomposition (1846 algorithm, perfect for 1960s hardware) |
| `SPCONS` | `spcons.f` | Conservation ratio computation (gradient variance of spectral projection) |
| `SPSGAP` | `sgap.f` | Spectral gap (largest gap between consecutive eigenvalues) |
| `SPCHKR` | `chkr.f` | Cheeger constant approximation from Fiedler vector |
| `SPANMI` | `anom.f` | Anomaly tracker initialization |
| `SPANOM` | `anom.f` | Anomaly detection via sliding window z-score |
| `SPFING` | `fing.f` | Spectral fingerprint (hash-based eigenvalue encoding) |
| `SPFDCP` | `fing.f` | Fingerprint comparison (similarity metric) |
| `SPMAIN` | `spmain.f` | Main driver — full analysis of 5-node chord progression |

## 1960s Computing Constraints

- **Fixed-form source** (columns 7-72 only)
- **No dynamic memory** — all arrays fixed-size via `DIMENSION`
- **No structured programming** — `IF`/`GOTO` only, arithmetic IF
- **6-character variable names max**
- **COMMON blocks** for shared state
- **No recursion**
- **Implicit typing** — I-N are INTEGER, everything else REAL (watch out for names starting with L!)
- **No CHARACTER type** — uses Hollerith constants and format strings
- **Arithmetic IF**: `IF (expr) label1, label2, label3`
- **Column-major storage** — inner loops vary first index for cache-friendly access

## Build & Run

```bash
gfortran -ffixed-form -std=legacy -o spmain \
  splapl.f spjacb.f spcons.f sgap.f chkr.f anom.f fing.f spmain.f

./spmain
```

## Test Case: 5-Node Chord Progression

The canonical test vector represents a musical chord progression:

- Node 1: C (tonic)
- Node 2: Am (relative minor)
- Node 3: F (subdominant)
- Node 4: G (dominant)
- Node 5: C' (tonic octave)

Edges are weighted by transition probability, symmetrized for the undirected Laplacian.

## Sample Output

```
 LAPLACIAN MATRIX
    1.1000   -0.1500   -0.3000   -0.4000   -0.2500
   -0.1500    0.8000   -0.2000   -0.0500   -0.4000
   -0.3000   -0.2000    0.9000   -0.3000   -0.1000
   -0.4000   -0.0500   -0.3000    1.1000   -0.3500
   -0.2500   -0.4000   -0.1000   -0.3500    1.1000

 EIGENVALUES
   -0.5403    0.1516    1.2817    1.4521    1.7463

 SPECTRAL GAP =     1.130090
 CHEEGER CONSTANT =     2.000000

 ANOMALY STATUS = 2 (CRITICAL) when fed 999.0
```

## Lessons Learned (Authentic 1960s Debugging)

1. **Implicit typing traps**: Variable `LPLC` starts with `L` → implicitly INTEGER in FORTRAN IV. Must declare `REAL LPLC` explicitly.
2. **Array dimension mismatch**: Passing a `DIMENSION(50,50)` array to a subroutine using `DIMENSION(N,N)` causes stride mismatch. Use fixed max dimensions everywhere.
3. **Integer/REAL argument passing**: `CALL SUB(5)` passes integer 5 by reference; if the subroutine expects REAL, the bit pattern is wrong. Use `CALL SUB(5.0)`.
4. **Hollerith format limits**: Special characters like `=`, `*`, `.` inside Hollerith constants can confuse modern compilers. Use quoted strings for portability.

## License

Public domain. This is a museum piece.
