Return-Path: <B10812@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EDE202C023F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jul 2012 17:36:41 +1000 (EST)
From: Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Singh Sandeep-B37400
 <B37400@freescale.com>
Subject: RE: [PATCH][upstream] TDM Framework
Date: Sat, 21 Jul 2012 07:36:33 +0000
Message-ID: <ACB6D0C0104CFF42A45A5D82A0DD4F3D079B3791@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1342787714-8415-1-git-send-email-sandeep@freescale.com>
 <20120721005005.ace23a85cf3f0d2589990d00@canb.auug.org.au>
In-Reply-To: <20120721005005.ace23a85cf3f0d2589990d00@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Singh Sandeep-B37400 <B37400@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry the documentation patch got missed in this patchset.

Will send it again.

Regards
Poonam

> -----Original Message-----
> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]
> Sent: Friday, July 20, 2012 8:20 PM
> To: Singh Sandeep-B37400
> Cc: linuxppc-dev@lists.ozlabs.org; Singh Sandeep-B37400; Aggrwal Poonam-
> B10812
> Subject: Re: [PATCH][upstream] TDM Framework
>=20
> Hi,
>=20
> On Fri, 20 Jul 2012 18:05:13 +0530 <sandeep@freescale.com> wrote:
> >
> > From: Sandeep Singh <Sandeep@freescale.com>
> >
> > TDM Framework is an attempt to provide a platform independent layer
> > which can offer a standard interface  for TDM access to different
> client modules.
>=20
> I also wondered what TDM is.
>=20
> > +++ b/drivers/tdm/Kconfig
> > @@ -0,0 +1,18 @@
> > +#
> > +# TDM subsystem configuration
> > +#
> > +
> > +menuconfig TDM
> > +	tristate "TDM support"
> > +	---help---
> > +	  More information is contained in the directory
> > +<file:Documentation/tdm/>,
>=20
> ^^^^^^^^^^^^^^^^^^
> > +	  especially in the file called "summary" there.
>                                          ^^^^^^^
>=20
> It might help if those files were included in the patch set ...
>=20
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
