Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B0065DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Aug 2007 01:52:48 +1000 (EST)
Message-ID: <46B743C6.1030905@freescale.com>
Date: Mon, 06 Aug 2007 10:52:38 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: poorbeyond <poorbeyond@163.com>
Subject: Re: my cpu is MPC860, kernel version is 2.6.20.14,	the kernel start
	info in the mail. why does the kernel panic?
References: <200708051854252184131@163.com>
In-Reply-To: <200708051854252184131@163.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linux-ppc mail list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

poorbeyond wrote:
> Linux version 2.6.20.14 (root@localhost.localdomain) (gcc version 4.0.0 (DENX ELDK 4.0 4.0.0)) #1 PREEMPT Sun Aug 5 18:23:18 CST 2007

It wouldn't surprise me if the 8xx code has issues with PREEMPT; try 
turning it off for now.

> 
> ------------[ cut here ]------------
> 
> Badness at 00200880 [verbose debug info unavailable]
> 
> Call Trace:
> 
> [00285E60] [00008E24]  (unreliable)
> 
> [00285E90] [000EBA14] 
> 
> [00285EA0] [00003D88] 

Enable verbose debug messages and kallsyms for more useful output.

Are you running arch/ppc or arch/powerpc?

-Scott
