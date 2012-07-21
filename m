Return-Path: <B10812@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C8532C0404
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jul 2012 17:36:52 +1000 (EST)
From: Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Josh Boyer <jwboyer@gmail.com>, Michael Ellerman <michael@ellerman.id.au>
Subject: RE: [PATCH][upstream] TDM Framework
Date: Sat, 21 Jul 2012 07:36:43 +0000
Message-ID: <ACB6D0C0104CFF42A45A5D82A0DD4F3D079B37CA@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1342787714-8415-1-git-send-email-sandeep@freescale.com>
 <1342788865.28608.0.camel@concordia>
 <CA+5PVA7XSv7Fbg8DLCZMPmOzMX6uDnxzsAna2gW4RCfH7=eCUg@mail.gmail.com>
In-Reply-To: <CA+5PVA7XSv7Fbg8DLCZMPmOzMX6uDnxzsAna2gW4RCfH7=eCUg@mail.gmail.com>
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
> From: Josh Boyer [mailto:jwboyer@gmail.com]
> Sent: Friday, July 20, 2012 6:57 PM
> To: Michael Ellerman
> Cc: Singh Sandeep-B37400; Aggrwal Poonam-B10812; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH][upstream] TDM Framework
>=20
> On Fri, Jul 20, 2012 at 8:54 AM, Michael Ellerman
> <michael@ellerman.id.au> wrote:
> > On Fri, 2012-07-20 at 18:05 +0530, sandeep@freescale.com wrote:
> >> From: Sandeep Singh <Sandeep@freescale.com>
> >>
> >> TDM Framework is an attempt to provide a platform independent layer
> >> which can offer a standard interface  for TDM access to different
> client modules.
> >> Beneath, the framework layer can house different types of TDM drivers
> >> to handle various TDM devices, the hardware intricacies of the
> >> devices being completely taken care by TDM drivers.
> >
> > TDM ?
>=20
> And here I was thinking I was the only one scratching his head.  All I
> could come up with was Time Division Multiplexing.
>=20
Sorry for that. TDM refers to Time Division Multiplexing. Actually the firs=
t version of this patch set also had a patch which documented TDM basics.
We missed it this time.

Will just send the TDM documentation patch also.

Regards
Poonam

For your reference:

> Protip: If you use an acronym a billion times in a patch, expand it at
> least in one place.
>=20
> josh
