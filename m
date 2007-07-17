Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 14AA0DDEF5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jul 2007 08:55:44 +1000 (EST)
Message-ID: <469D47DB.7070804@freescale.com>
Date: Tue, 17 Jul 2007 17:51:07 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Siva Prasad <sprasad@bivio.net>
Subject: Re: Linuxppc-embedded Digest, Vol 35, Issue 33
References: <mailman.1061.1184600645.8639.linuxppc-embedded@ozlabs.org>
	<D83235F0F3C86D4D889D8B9A0DA8C6D78D7DE9@corpexc01.corp.networkrobots.com>
	<469B9825.6070507@freescale.com>
	<e5eb93010707162259l2e78c524s32ff260b3d930bdb@mail.gmail.com>
	<D83235F0F3C86D4D889D8B9A0DA8C6D78D7FAF@corpexc01.corp.networkrobots.com>
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D78D7FAF@corpexc01.corp.networkrobots.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: suresh suresh <sureshtang@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Siva Prasad wrote:
> Well!... you can manage any way you want.
> 
>  
> 
> 1) You can store the virtual address in the DpRAM, and convert to
> physical (should I say DMA mapped address) and then pass it on to the
> device under consideration here.

The DPRAM is read directly by the microcode (if it didn't, you'd just be 
using RAM).  You don't want to put virtual addresses in there.

-Scott
