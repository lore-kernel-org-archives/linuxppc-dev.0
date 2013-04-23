Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id 70B922C015B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 12:00:28 +1000 (EST)
Date: Tue, 23 Apr 2013 12:00:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 12/12]  Add /proc interface to control topology updates
Message-Id: <20130423120026.85860c95d1c82582fa9a6ef5@canb.auug.org.au>
In-Reply-To: <517585DB.9040603@linux.vnet.ibm.com>
References: <51757951.2080007@linux.vnet.ibm.com>
 <517585DB.9040603@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__23_Apr_2013_12_00_26_+1000_piXMhFQCklcla152"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__23_Apr_2013_12_00_26_+1000_piXMhFQCklcla152
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Mon, 22 Apr 2013 13:47:55 -0500 Nathan Fontenot <nfont@linux.vnet.ibm.co=
m> wrote:
>
>  #if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
>  extern int start_topology_update(void);
>  extern int stop_topology_update(void);
> +extern inline int prrn_is_enabled(void);

You really can't do "extern inline" with no body ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__23_Apr_2013_12_00_26_+1000_piXMhFQCklcla152
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRdes6AAoJEECxmPOUX5FEtEkP/ihRkONER/dI/eFj1Yctxsbe
xm838JDw1FsO4RzUcZl3oeeX0rT8WcPQU/Dym12OOj4aemiq7HmAeOvx/+zhVK+O
T1anNdzj+braI4/utfbpf512od9kpUsuVHW6Livfc3nFcv+oplBK/mJ5zYmUzksV
+vEG7OXFU3+Ya7Qwv6XKaGPcxH9GUDRSK1yCCXnMiFTyN3m1fWU723W717fBlGkN
S2LHnKFh4bjQhkgcXMZTXV+Z26UDYaj3h3FMbEljoShYntJ4xRghcIIoo2RmM7nw
3J7W/CyTYdFOlS9R8aJMADYQae/eVlU+3cXZkoKsXnkbVc4pdljw043n4+2WaEY8
NAHDRxxnBAD3DrNK72s0AQxnqco3tpTfnKp2zcZlnkYJpumkk461B1JhNcSiIE9T
3aklU69E//IDgmogfCAq/sEXXc8oO2OHLILhSWocCzckchPYI7xodirdxIR3GINz
zlEhdKroCc4ORYGEptawVSUNoqsKf1ZB0tuWSOmC/zSUq5v0CUSbLUXvr92JigQK
3CVrblk9CHpetTg4Lt3P7lz1MtvywkdM25QMMulf9J2o8XcL03pbaGjNm3dC3c3v
c5O0WYyCIKdojoRb7mwRuWPMIZvcRof/AOzIztvlaifp9/Yg08Po2W2cV/lxkcKP
y2ItTLLUKh+tLGZXJ0Lc
=XoMe
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Apr_2013_12_00_26_+1000_piXMhFQCklcla152--
