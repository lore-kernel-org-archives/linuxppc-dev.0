Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 15466DDEF7
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 02:20:06 +1000 (EST)
Subject: Re: [PATCH] powerpc: fix MAC address entries for 83xx, 85xx, and
	86xx device trees
From: Jon Loeliger <jdl@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <70d005ce549921cc56481fe0b26faaa4@kernel.crashing.org>
References: <11825407952085-git-send-email-timur@freescale.com>
	<70d005ce549921cc56481fe0b26faaa4@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1182788398.26135.5.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 25 Jun 2007 11:19:58 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-06-23 at 10:50, Segher Boessenkool wrote:
> > For the 83xx, 85xx, and 86xx device trees, add a "local-mac-address" 
> > property
> > to every Ethernet node that didn't have one.  Add a comment indicating 
> > that
> > the "address" and/or "mac-address" properties are deprecated in DTS 
> > files
> > and will be removed at a later time.  Change all MAC address 
> > properties to
> > have a zero MAC address value.
> 
> Shouldn't you use the "??" notation instead, or is that
> still not implemented?

That is correct.  It is still not implemented.

jdl
