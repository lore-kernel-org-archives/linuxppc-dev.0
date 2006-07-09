Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 696B4679E1
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Jul 2006 22:31:57 +1000 (EST)
Subject: Re: MPC5200 boot giving "request_module: runaway loop modprobe
	binfmt-4c46" errors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: gturnock@ivhs.com
In-Reply-To: <OF8ECEFEB4.081DB077-ON852571A4.007A4DD5-852571A4.007A4DEE@fpelectronics.com>
References: <OF8ECEFEB4.081DB077-ON852571A4.007A4DD5-852571A4.007A4DEE@fpelectronics.com>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 22:31:48 +1000
Message-Id: <1152448308.4128.35.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Fri, 2006-07-07 at 18:15 -0400, gturnock@ivhs.com wrote:
> Hi All,
> 
> I am currently attempting to get the 2.6 Linux Kernel
> ( Sylvain's Kernel from
> http://gitbits.246tNt.com/gitbits/linux-2.6-mpc52xx.git)  booting over
> NFS on a Freescale LITE5200 board.  At present, I have been able to
> successfully mount the rootfs over NFS, but am encountering the
> following issue... 
> 
> After the kernel frees the unused memory after the NFS mount, I get a
> string of 
> 
> request_module: runaway loop modprobe binfmt-4c46
> 
> errors and the console appears to hang.  Any help would be greatly
> appreciated!

Are you sure you are trying to boot a ppc NFS root ? :) Looks to me like
you are trying to boot an x86 one...

Ben.
