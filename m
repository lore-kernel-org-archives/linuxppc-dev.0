Return-Path: <B10812@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F1CED2C031F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jul 2012 19:20:52 +1000 (EST)
From: Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Aggrwal Poonam-B10812 <B10812@freescale.com>, Josh Boyer
 <jwboyer@gmail.com>, Michael Ellerman <michael@ellerman.id.au>
Subject: RE: [PATCH][upstream] TDM Framework
Date: Sat, 21 Jul 2012 09:20:44 +0000
Message-ID: <ACB6D0C0104CFF42A45A5D82A0DD4F3D079B3996@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1342787714-8415-1-git-send-email-sandeep@freescale.com>
 <1342788865.28608.0.camel@concordia>
 <CA+5PVA7XSv7Fbg8DLCZMPmOzMX6uDnxzsAna2gW4RCfH7=eCUg@mail.gmail.com>
 <ACB6D0C0104CFF42A45A5D82A0DD4F3D079B37CA@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <ACB6D0C0104CFF42A45A5D82A0DD4F3D079B37CA@039-SN2MPN1-013.039d.mgd.msft.net>
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



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+poonam.aggrwal=3Dfreescale.com@lists.ozlabs.org] On Behalf Of
> Aggrwal Poonam-B10812
> Sent: Saturday, July 21, 2012 1:07 PM
> To: Josh Boyer; Michael Ellerman
> Cc: linuxppc-dev@lists.ozlabs.org; Singh Sandeep-B37400
> Subject: RE: [PATCH][upstream] TDM Framework
>=20
>=20
>=20
> > -----Original Message-----
> > From: Josh Boyer [mailto:jwboyer@gmail.com]
> > Sent: Friday, July 20, 2012 6:57 PM
> > To: Michael Ellerman
> > Cc: Singh Sandeep-B37400; Aggrwal Poonam-B10812; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH][upstream] TDM Framework
> >
> > On Fri, Jul 20, 2012 at 8:54 AM, Michael Ellerman
> > <michael@ellerman.id.au> wrote:
> > > On Fri, 2012-07-20 at 18:05 +0530, sandeep@freescale.com wrote:
> > >> From: Sandeep Singh <Sandeep@freescale.com>
> > >>
> > >> TDM Framework is an attempt to provide a platform independent layer
> > >> which can offer a standard interface  for TDM access to different
> > client modules.
> > >> Beneath, the framework layer can house different types of TDM
> > >> drivers to handle various TDM devices, the hardware intricacies of
> > >> the devices being completely taken care by TDM drivers.
> > >
> > > TDM ?
> >
> > And here I was thinking I was the only one scratching his head.  All I
> > could come up with was Time Division Multiplexing.
> >
> Sorry for that. TDM refers to Time Division Multiplexing. Actually the
> first version of this patch set also had a patch which documented TDM
> basics.
> We missed it this time.
>=20
> Will just send the TDM documentation patch also.
The documentation patch is at:
http://patchwork.ozlabs.org/patch/145857/

>=20
> Regards
> Poonam
>=20
> For your reference:
>=20
> > Protip: If you use an acronym a billion times in a patch, expand it at
> > least in one place.
> >
> > josh
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
