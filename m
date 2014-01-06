Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 6 Jan 2014 20:28:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the final tree
Message-Id: <20140106202856.5630590efc4bd6a466b7a668@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__6_Jan_2014_20_28_56_+1100_vCtbRul1wB6sgmw1"
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__6_Jan_2014_20_28_56_+1100_vCtbRul1wB6sgmw1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the final tree, today's linux-next build (powerpc
allyesconfig) failed like this:

arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
arch/powerpc/kernel/exceptions-64s.S:1312: Error: attempt to move .org back=
wards

The last time I got this error, I needed to apply patch "powerpc: Fix
"attempt to move .org backwards" error", but that has been included in
the powerpc tree now, so I guess something else has added code in a
critical place. :-(

I have just left this broken for today.
--=20
Cheers,
Stephen Rothwell <sfr@canb.auug.org.au>

--Signature=_Mon__6_Jan_2014_20_28_56_+1100_vCtbRul1wB6sgmw1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSynddAAoJEMDTa8Ir7ZwVcX4P/3rfUfTUuhHYjgrc55BrVifu
GiHfPjRESMHFmCXQvXMxlW36FvLi7UUuL9zvx7EuBGERCyKJSavcXJpgAb9amgfW
Uz/hhPX2pan8584SfIX4W741AGgsycgsgTW55fx0j70XWngHGNEVm5Q+IQyLx/8p
1zpizXVWwotTsnj/9BtLUqDdQyGZcHLSWfZPGt7ycVTFPbex9nfDtlrKNto2ZG4F
vcgusyflP94z8y2sxWIUN0V8EetH9j0kcuZXl47vr+tPN52cbyBe13WrOlQuZqDH
hsXno7yXLUUIexrI12ex9LtFH8NuZnhApRX/ckxwiTaTBhPnpF9Wioiv8MGsAzUe
KTMoftUgrg8lNIrBwMjqh8dw6AHDFNg8lnz1F8yELWgYyIz80ZEQg9GEuu0gbKjs
qiJogFqt7N5u28FNSaJc8te48s/+2zqje0+trnacUlPEdOzMeMdRRSjaouWR/+q2
gpVNuY8GHohNkmAFMBef8huxHPPrOTtE4Lj3zO0x0tpWydcWRNGTTvMyQObrk1Hg
iLaR5jZL0/oo+b7gNOk+2RWQVWOYpDas1KwzHmGchJ4EOTdBKgCvCqwiTU6gADDR
lKZYaBHgQql8mS1Bs3Nyaac8UsN7UZR3N8enZRx1k4oncKQjUpLNUqKxPbR0WWHU
cyb6AhiajJZzw5MrdfsB
=cLZ0
-----END PGP SIGNATURE-----

--Signature=_Mon__6_Jan_2014_20_28_56_+1100_vCtbRul1wB6sgmw1--
