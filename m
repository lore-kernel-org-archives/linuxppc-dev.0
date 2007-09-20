Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6C9B3DDF63
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 04:16:35 +1000 (EST)
Message-ID: <46F2B8FD.7040501@freescale.com>
Date: Thu, 20 Sep 2007 13:16:29 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] [POWERPC] Fix QEIC->MPIC cascading
References: <20070920130244.GA18043@localhost.localdomain>
	<46F2A7CC.1040106@freescale.com>
	<20070920174159.GA10765@localhost.localdomain>
In-Reply-To: <20070920174159.GA10765@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> I don't know (didn't look) why this works for 83xx w/o ack()...
> maybe IPIC don't need this. Or maybe there is a bug hiding.

Scott W told me that me that the IPIC doesn't have the concept of EOI ack.  It 
just has IRQ masks.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
