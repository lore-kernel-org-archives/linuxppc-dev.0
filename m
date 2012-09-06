Return-Path: <balbi@ti.com>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
 [74.125.149.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DF6062C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 00:36:38 +1000 (EST)
Received: by lags15 with SMTP id s15so1018687lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Sep 2012 07:36:35 -0700 (PDT)
Date: Thu, 6 Sep 2012 17:32:13 +0300
From: Felipe Balbi <balbi@ti.com>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: Re: [PATCH] usb: gadget: fsl_udc_core: remove mapped flag
Message-ID: <20120906143211.GY29202@arwen.pp.htv.fi>
References: <1346779499-6085-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
 <F281D0F91ED19E4D8E63A7504E8A649803C67DB9@039-SN2MPN1-023.039d.mgd.msft.net>
 <lya9x31atf.fsf@ensc-virt.intern.sigma-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/hzbcv1ZPoZ/SOgH"
In-Reply-To: <lya9x31atf.fsf@ensc-virt.intern.sigma-chemnitz.de>
Cc: Li Yang-R58472 <r58472@freescale.com>,
 Chen Peter-B29397 <B29397@freescale.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "balbi@ti.com" <balbi@ti.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--/hzbcv1ZPoZ/SOgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2012 at 04:32:28PM +0200, Enrico Scholz wrote:
> Chen Peter-B29397 <B29397@freescale.com> writes:
>=20
> > If the class driver has already mapped this address, the req->req.dma i=
s not
> > DMA_ADDR_INVALID either, in this case, the dma_sync_single_for_cpu is
> > enough.
>=20
> ok; forget the patch then.

fair enough, when can I get generic map/unmap conversion patch ?

--=20
balbi

--/hzbcv1ZPoZ/SOgH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQSLPrAAoJEIaOsuA1yqREeFAQAIbpu3RGHEWXGb2lQDZOehDa
1VcBrlUaC6uJsDB5cH7qaFJ6jzwHfmfikG1Qgd1WtcJ/3pyR4Ty6STikJ8uE8EbQ
vBM9FAgYMpK5e4xgMuSIWrbThRU41zZhCm+CG8wTO8qjuEglEwpwTTU9Cy2t54vX
RCyJjPRGn12IJISShlr/K3ZbyquYqG+qp8lLu42nARHKchiGRxaPcPlsVMzvUtCa
U+P4E8AY+j7QLYx//BhTPWw6YGQgGWQlSwyig37YTh9quYp8gmwWgt4ZGOFFG8G5
kGAlY0fKctuP4e03wVo9REj3Q7IPg+nhtAUNUw9i8qVsLJhghctUyELJDd53pRHG
0v2LV6CQLWW6FIXv5dCpzEo3rszgAhOmXA0EvbBZF6RVXi4fb14wZVgkeJdaT5Yq
BvCoewyCHHZlqyCyKQJrUb4IHEsHuUXsf6tIv8uXp8vBENPHXWhn6QQe1KkU05d6
RvsJbD2gtM1xb0uBYrqX3BmlMfmhqvTFRIlpvo9X+2Ijvisevv7/hzaoXNXfuIzD
jxpogtk9TkPriz1yAA9RHVcaR5c2FEnyvp2UmDk/HInFebhXF6XjccOOr9QzM9Jr
HCqA7EhjvKucLIb9zUE1WHHAzgLO/y02ojVoSkYjeVP98Rso9VVGsovvXvmC242y
1yHnA8WQIyBSjRBDYMY0
=oFGc
-----END PGP SIGNATURE-----

--/hzbcv1ZPoZ/SOgH--
