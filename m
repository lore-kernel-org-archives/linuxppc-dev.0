Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 66A42DE21D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 02:07:13 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m5BG77Xn006285 for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 09:07:07 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5BG76dR013430
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 11:07:06 -0500 (CDT)
Date: Wed, 11 Jun 2008 11:07:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: vb <vb@vsbe.com>
Subject: Re: PPC to PowerPC Migration
Message-ID: <20080611160706.GA4439@ld0162-tx32.am.freescale.net>
References: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com>
	<161B3BAD77161449A144FF054231C3D6022A3E4A@uss-am-xch-01.am.trimblecorp.net>
	<f608b67d0806110655v19dac162wc3adfc8939b5c40a@mail.gmail.com>
	<484FDB3D.4040101@freescale.com>
	<f608b67d0806110833h3675232pbaee901ea2664568@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f608b67d0806110833h3675232pbaee901ea2664568@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org, Mike Timmons <mike_timmons@trimble.com>,
	Andy Schmidt <andrewgschmidt@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jun 11, 2008 at 08:33:57AM -0700, vb wrote:
> my favorite was interrupt-map in PCI section:  A typical value would
> look like this:
> 
>                 interrupt-map = <
> 
>                         /* IDSEL 0x10 */
>                         08000 0 0 1 &mpic 0 1
>                         08000 0 0 2 &mpic 1 1
>                         08000 0 0 3 &mpic 2 1
>                         08000 0 0 4 &mpic 3 1
> 
> 
>                         [ repeated per IDSEL ]
> 
>                >
> 
> I don't see 'interrupt-map' mentioned anywhere in the ./Documentation
> tree - it took me a while to find out what these numbers actually
> meant.

It's documented here:
http://playground.sun.com/1275/practice/#imap

Once the ePAPR document is released, there'll be an all-in-one document,
but for now the documentation is somewhat scattered.

-Scott
