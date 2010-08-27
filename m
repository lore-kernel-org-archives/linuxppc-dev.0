Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 71E3BB70E4
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Aug 2010 12:01:49 +1000 (EST)
Date: Fri, 27 Aug 2010 12:01:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Power machines fail to boot after build being successful
Message-Id: <20100827120144.1736a2f6.sfr@canb.auug.org.au>
In-Reply-To: <2311.1282871746@neuling.org>
References: <4C764F52.5050707@linux.vnet.ibm.com> <2311.1282871746@neuling.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__27_Aug_2010_12_01_44_+1000_Dil0SsSW2lFw/4x2"
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, divya <dipraksh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__27_Aug_2010_12_01_44_+1000_Dil0SsSW2lFw/4x2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mikey,

On Fri, 27 Aug 2010 11:15:46 +1000 Michael Neuling <mikey@neuling.org> wrot=
e:
>
> > After successfully building the kernel version
> > 2.6.36-rc2-git4(commitid d4348c678977c) with the config file
> > attached(used make oldconfig), P5 and P6 power machines fails to
> > reboot with the following logs
> >=20
> > Logs collected while rebooting into today next, same occurs with the
> > upstream kernel too.
>=20
> This will fix your problem:
> http://patchwork.ozlabs.org/patch/62757/=20

I have seen something similar in my linux-next boot tests, so I will add
this patch to linux-next for today.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__27_Aug_2010_12_01_44_+1000_Dil0SsSW2lFw/4x2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMdxyIAAoJEDMEi1NhKgbsqLkH/23RUwxGj0loh2IErMyUZeya
AGkL3xt1wQY7PHUDH76s+TZcNnJhDa+mzdsQ04UDy8a7TGw9MU19OeFnHy3DBat4
ZdGbNey9IHUD2yRhflD7G+fajz/Sd0LDXmyQuDaRbpr6pGBJniJ0AnT03Cq4KPjT
SxSzCPcqCkN/HemQCvD775QBf/ao9eM3hfAemdb81OuKUWpdcz3knXdXRiDnT61k
zvXBpHmNVdFnkq9BGwhC3IJLXbi9/lduBHbTVr2RsfG+mlvZ5cTVxfVZqXLsBlHf
GIAXlRaohBH1R/1a2ZhOSGxcPyKWcPo835/HHne1HHyiLyjroZlF8HtZbkorAkA=
=h2Ag
-----END PGP SIGNATURE-----

--Signature=_Fri__27_Aug_2010_12_01_44_+1000_Dil0SsSW2lFw/4x2--
