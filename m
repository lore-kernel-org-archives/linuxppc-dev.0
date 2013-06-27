Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id D099C2C0092
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 14:05:47 +1000 (EST)
Date: Thu, 27 Jun 2013 14:05:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/4] powerpc: Rename and flesh out the facility
 unavailable exception handler
Message-Id: <20130627140539.5ff63bad1e7e99e5526d0f3d@canb.auug.org.au>
In-Reply-To: <1372146477-4338-3-git-send-email-michael@ellerman.id.au>
References: <1372146477-4338-1-git-send-email-michael@ellerman.id.au>
 <1372146477-4338-3-git-send-email-michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__27_Jun_2013_14_05_39_+1000_nE2L=sZwMBER6ruh"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__27_Jun_2013_14_05_39_+1000_nE2L=sZwMBER6ruh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, 25 Jun 2013 17:47:56 +1000 Michael Ellerman <michael@ellerman.id.au=
> wrote:
>
> -void tm_unavailable_exception(struct pt_regs *regs)
> +void facility_unavailable_exception(struct pt_regs *regs)
>  {
> +	static char *facility_strings[] =3D {
> +		"FPU",
> +		"VMX/VSX",
> +		"DSCR",
> +		"PMU SPRs",
> +		"BHRB",
> +		"TM",
> +		"AT",
> +		"EBB",
> +		"TAR",
> +	};

Are the indexes into this array defined somewhere?  If not, can we do
that.  Then, can we use explicit indexed initialisers for this array?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__27_Jun_2013_14_05_39_+1000_nE2L=sZwMBER6ruh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRy7oXAAoJEECxmPOUX5FEv1cP/2TkP85Ryny3XQ7gvXbL+nkv
qF8U7FvFsH8M3t5aBo66TMDeDFrNCAeATLfTYYgjrn+VhPBp1tHtEz36SwFic8wo
IZwO/OvATXlhDcD8YYixvMDqc12FwfG3ZjYKQH0trxva5ce+z7jLS85bwnORsFts
3dbnAoWF0ogbMPouu8TuzwjAgT0YWAVxoCjdSdeI2gAms0kkHGlusvRnciU6Gk+B
66gsWRu8SgsmobP7cMK+jSGFTdd/SeG3SYgwmxAJuB7/RMtPYBeeWXg3FYkbKVK9
iOMwscdE7x/Pm49Aq7TabqD1pyqUP/I6leLPQmQuu3z6PIx9B55AEo3wK4Wf46so
3u1xf+bvnEQ3o2Fexl4yT4uleW27ikzY7ZSbbClbER4e+ZhM3xOckyEguf6LrueQ
+Vpjh2rAgN8nE/RbzFCgo51hg9I2Z3KFdyD8cXj3HXN11hfV2ghTJlz4BhmZoawc
UqN0Q6zaggpvtCrhPq0XMvmO2ZwQZKq592U+o9hKMaU5kIe/9u+QGrzIucSqT+J4
+UdNVnlPPZZQn0rTcBSNus+U3pzhTWGsxlU9nId/VqQgQhcF4q9h15qsaxWxhFgt
HEqGP/kpP3AQQxC/qD+Q2IXMTx8Za0nZpDZcX/vHgEMyv/b0NYnm50wgb5VHMmMP
gE1MFhrVe/q65fuOy/Yh
=gHgn
-----END PGP SIGNATURE-----

--Signature=_Thu__27_Jun_2013_14_05_39_+1000_nE2L=sZwMBER6ruh--
