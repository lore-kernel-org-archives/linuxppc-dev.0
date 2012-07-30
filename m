Return-Path: <B10812@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B49FF2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 19:13:13 +1000 (EST)
From: Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Greg KH <gregkh@linuxfoundation.org>, Singh Sandeep-B37400
 <B37400@freescale.com>
Subject: RE: [2/3][PATCH][v2] TDM Framework
Date: Mon, 30 Jul 2012 09:13:02 +0000
Message-ID: <ACB6D0C0104CFF42A45A5D82A0DD4F3D079C0BEC@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727181208.GC23105@kroah.com>
In-Reply-To: <20120727181208.GC23105@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+poonam.aggrwal=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Gre=
g
> KH
> Sent: Friday, July 27, 2012 11:42 PM
> To: Singh Sandeep-B37400
> Cc: devel@driverdev.osuosl.org; linuxppc-dev@lists.ozlabs.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [2/3][PATCH][v2] TDM Framework
>=20
> On Fri, Jul 27, 2012 at 07:35:38PM +0530, sandeep@freescale.com wrote:
> > +static struct kobj_type tdm_type =3D {
> > +	.sysfs_ops =3D &tdm_ops,
> > +	.default_attrs =3D tdm_attr,
> > +};
>=20
> Ah, also, as per the documentation in the kernel (go look, it's there), I
> now get to publicly mock you for ignoring the error messages that the
> kernel is giving you when you try to shut down your code path.
>=20
> Well, to be fair, you are leaking memory like a sieve, so I doubt you
> ever saw those error messages because you never cleaned up after
> yourself, so perhaps I can forgive you, but your users can't, sorry.
> They like to rely on the fact that Linux is a reliable operating system,
> don't cause them to doubt that.
>=20
> Please fix this code, it's horribly broken.  Read
> Documentation/kobject.txt for why.  That file was written for a reason,
> and not just because we like writing documentation (hint, we hate to...)
To be honest we are not sysfs experts. Thanks for pointing to the documenta=
tion.
We will rework the stuff.

Regards
Poonam
>=20
> Ugh,
>=20
> greg k-h
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
