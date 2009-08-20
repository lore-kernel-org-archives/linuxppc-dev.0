Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 581CFB7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 04:01:23 +1000 (EST)
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) by ozlabs.org (Postfix) with ESMTP id B8E65DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 04:01:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH] [V3] net: add Xilinx emac lite device driver
Date: Thu, 20 Aug 2009 10:45:03 -0700
In-Reply-To: <fa686aa40908201044y17acb4c1lacf09fafc2647fa4@mail.gmail.com>
References: <20090820094956.02DFC45004F@mail96-dub.bigfish.com>
	<20090820160356.F1A03340054@mail79-sin.bigfish.com>
	<fa686aa40908201044y17acb4c1lacf09fafc2647fa4@mail.gmail.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-ID: <20090820174607.05A1AC10058@mail141-va3.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Sadanand Mutyala <sadanan@xilinx.com>, John Linn <linnj@xilinx.com>,
	Michal Simek <michal.simek@petalogix.com>, jgarzik@pobox.com,
	davem@davemloft.net, John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry... you're right... brain fart on my part.. :)

Steve

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of Gra=
nt Likely
> Sent: Thursday, August 20, 2009 10:45 AM
> To: Stephen Neuendorffer
> Cc: John Linn; netdev@vger.kernel.org; linuxppc-dev@ozlabs.org; davem@dav=
emloft.net;
> jgarzik@pobox.com; John Linn; Sadanand Mutyala; John Williams; Michal Sim=
ek
> Subject: Re: [PATCH] [V3] net: add Xilinx emac lite device driver
> =

> On Thu, Aug 20, 2009 at 10:02 AM, Stephen
> Neuendorffer<stephen.neuendorffer@xilinx.com> wrote:
> >
> > John,
> >
> > I just got a chance to browse this... =A0Do you want to put in the
> > stripped device names?
> >
> > .compatible =3D "xlnx,xps-ethernetlite-2", etc...
> =

> We've covered this territory before.  Compatible values need to be
> exact for the IP cores.  No wildcards. No abbreviations or stripping.
> Newer cores can claim compatibility with older when appropriate.
> =

> g.
> =

> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
