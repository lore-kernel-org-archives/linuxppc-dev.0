Return-Path: <balbi@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 532EF2C01FD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2012 01:40:56 +1100 (EST)
Date: Wed, 31 Oct 2012 16:34:53 +0200
From: Felipe Balbi <balbi@ti.com>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 2/3] usb: gadget: fsl_qe_udc: do not use tasklet_disable
 before tasklet_kill
Message-ID: <20121031143453.GM10998@arwen.pp.htv.fi>
References: <1351670761-26749-1-git-send-email-xtfeng@gmail.com>
 <1351670761-26749-2-git-send-email-xtfeng@gmail.com>
 <20121031132650.GP10998@arwen.pp.htv.fi>
 <CADRPPNSQzCrHRQMoFf280pqS7AUOAzOq-swT3Hwagphiire5-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="B7kmwdlU7aE/dafw"
In-Reply-To: <CADRPPNSQzCrHRQMoFf280pqS7AUOAzOq-swT3Hwagphiire5-Q@mail.gmail.com>
Cc: Xiaotian Feng <dannyfeng@tencent.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, balbi@ti.com, Xiaotian Feng <xtfeng@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--B7kmwdlU7aE/dafw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2012 at 10:35:37PM +0800, Li Yang wrote:
> On Wed, Oct 31, 2012 at 9:26 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Wed, Oct 31, 2012 at 04:06:00PM +0800, Xiaotian Feng wrote:
> >> If tasklet_disable() is called before related tasklet handled,
> >> tasklet_kill will never be finished. tasklet_kill is enough.
> >
> > how did you test this ? Why changing FSL driver instead of switching
> > over to chipidea which is supposed to be shared by every licensee of the
> > chipidea core ?
>=20
> The QE UDC is an private controller that is not compatible with the
> Chipidea core.

thanks for the clarification, but you still haven't answered how you
tested this ;-)

--=20
balbi

--B7kmwdlU7aE/dafw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkTcNAAoJEIaOsuA1yqREb1MP/2qo5nTmhJ8vfTg0ttm2EixN
7dL1MILJ/puu72tbke6+84cAxDfqeSV1ZFM54nyKKg9fXqwVeIaCVe9vJNUDTLTN
6/51qAeyDbHOmoebvvFOpLfU/9o7jkCJdhQ71dPE1EoCHpBiRanoflqMkV748OiT
hJUCiqUUaBq1rp1lcAcXeYT7awVMeivoE5kkonIwTLF0lID9vcq33s/V1AKJlvUO
+B/zV1gIHEkjeKNuaQUttCzE43wWVEWL8Ofc+MqDTm9BpUVTOiB7/yXB20a66Rrd
B5NnPrF9/oDHCvldhq/dvvc/dLU7ubmedFqPlaOZdOqTNE2HvyuKgsGFmFJY/4vs
A8pcdAVMBmtjT+Ir56KqYpMrbCew4+She9cToV/Abad4Pr38YHI00mnxitHDVqrp
lj9jMsWmbLkvDQHlyNnTXZH90+2Jj0NTsbFItclUWO5Aah9PpQQXnebh20n5gWo4
nhIxYuHQZJdChIGaAhSXY6EuZ1p6in9jSaWye56edtGlbyJy+QpwSu7YPW7s39Nx
EsEkD1LHEtwceJkCtNdRqb1aUp4kLgh1SuwsCL8ERC41J/YS0fQ2sJ6k+CW/JuDJ
/wKZ1ljlTX3kCkEx4iIMXruP9REaWn5q5BmIdujvP+nfTuHDD+ijgWKE+JrFeY2V
amYBRAXQZBxfHPCC5SCC
=M6tX
-----END PGP SIGNATURE-----

--B7kmwdlU7aE/dafw--
