Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx024.isp.belgacom.be (outmx024.isp.belgacom.be
	[195.238.4.128])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C65568A83
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 03:02:48 +1100 (EST)
Received: from outmx024.isp.belgacom.be (localhost [127.0.0.1])
	by outmx024.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k0PG2aQc006082
	for <linuxppc-embedded@ozlabs.org>; Wed, 25 Jan 2006 17:02:36 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [RFC] arch/ppc/boot/simple/embed_boot.c : Merging all keyvals
	parsing code
Date: Wed, 25 Jan 2006 17:02:20 +0100
References: <200601251215.10816.laurent.pinchart@tbox.biz>
	<bc2424c0c5f69931784ea76791f8ee39@embeddedalley.com>
In-Reply-To: <bc2424c0c5f69931784ea76791f8ee39@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601251702.20332.laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > Should I submit a patch, or leave the code as it is ?
>
> Port Das U-Boot.

Of course, that's another solution. We will use Das U-Boot for our custom 
design.

What I wanted to do here is completely different. As the board comes with a 
proprietary boot loader, I thought it would be interesting for future users 
to have the board supported in the vanilla kernel, like many other boards 
are. Is that a mistake ?

Laurent Pinchart
