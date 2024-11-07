# CONTOH SMART CONTRACT MENGGUNAKAN FOUNDRY

## Install Foundry
<pre><code>
  curl -L https://foundry.paradigm.xyz | bash
</code></pre>

## Langkah Membuat SC
1. Buat direktori baru
<pre><code>
  mkdir myproject
</code></pre>

 2. Masuk ke direktori project
<pre><code>
  cd myproject
  forge init
</code></pre>

Itu akan membuat struktur seperti dibawah
<pre><code>
  .
├── foundry.toml
├── script
│   └── Counter.s.sol
├── src
│   └── Counter.sol
└── test
    └── Counter.t.sol
</code></pre>

3. Lalu jalankan
<pre><code>
  forge install openzeppelin/openzeppelin-contracts
</code></pre>

# LANJUT BESOK
