Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 81EAFDDD07
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 12:40:14 +1100 (EST)
In-Reply-To: <20070214233348.GH16279@localhost.localdomain>
References: <11713852392294-git-send-email-timur@freescale.com>
	<20070214003119.GF11491@localhost.localdomain>
	<45D29BBA.7090401@freescale.com>
	<20070214052440.GB12609@localhost.localdomain>
	<45D31734.7030808@freescale.com>
	<20070214233348.GH16279@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c8fe6c9c19018243871df0fb9ed23a0b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
Date: Thu, 15 Feb 2007 02:40:09 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> My point is that the interrupt-controller property in /chosen *should*
> be there, but it doesn't make a lot of sense for it to be set by the
> bootloader (because it's a fixed property of the board).

And that means it shouldn't be in /chosen at all.  It's not
just a fixed property of the board, it is a physical property
of the board.  It doesn't belong in /chosen.


Segher
