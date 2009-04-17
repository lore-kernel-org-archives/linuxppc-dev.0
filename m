Return-Path: <John.Linn@xilinx.com>
Received: from IE1EHSOBE001.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 1EDEBDDF0F
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 06:41:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Question about DBCR0 initialization for 440
Date: Fri, 17 Apr 2009 14:41:26 -0600
In-Reply-To: <20090417203531.GB3776@zod.rchland.ibm.com>
References: <20090414203313.8D8F11BE8056@mail209-sin.bigfish.com>
	<20090417154628.43F859D0055@mail178-wa4.bigfish.com>
	<625fc13d0904171022u4d7d5d8cve0ccfb74cc31f554@mail.gmail.com>
	<200904171307.47734.hollisb@us.ibm.com>
	<1239995087.7210.19.camel@pasglop>
	<fa686aa40904171210y56835f98jfa4f3e08d97930aa@mail.gmail.com>
	<20090417203053.1D692F88052@mail119-dub.bigfish.com>
	<20090417203531.GB3776@zod.rchland.ibm.com>
From: John Linn <John.Linn@xilinx.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Message-ID: <20090417204133.36D4EB80057@mail167-dub.bigfish.com>
Cc: Tirumala Reddy Marri <tmarri@amcc.com>,
	Hollis Blanchard <hollisb@us.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 =


> -----Original Message-----
> From: Josh Boyer [mailto:jwboyer@linux.vnet.ibm.com] =

> Sent: Friday, April 17, 2009 2:36 PM
> To: John Linn
> Cc: grant.likely@secretlab.ca; Benjamin Herrenschmidt; =

> linuxppc-dev@ozlabs.org; Hollis Blanchard; Tirumala Reddy Marri
> Subject: Re: Question about DBCR0 initialization for 440
> =

> On Fri, Apr 17, 2009 at 02:30:45PM -0600, John Linn wrote:
> >> > Might be worth checking if external debug is enabled, and =

> >> override it
> >> > only if it's not.
> >> =

> >> ppc440x5_um.pdf says that both can be enabled.
> >> =

> >
> >The code that I started the thread with, from the fsl file, =

> has conditional for the BDI around it.
> >
> >We think that we still need that conditional as the code is =

> not Oring in the enable such that it would
> >disable external debug mode for the BDI. But we need it this =

> way for our Xilinx pod.
> =

> EDM is a read-only bit according to the docs I have.  You =

> can't set it (or
> clear it) at all.  It's only set by external hardware.

That's strange, my 440x4_um.pdf does not say it's read-only unless it's
in some obscure place.

> =

> josh
> =

> =


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
