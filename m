Return-Path: <marcelo.tosatti@cyclades.com>
Received: from kanga.kvack.org (kanga.kvack.org [66.96.29.28])
	by ozlabs.org (Postfix) with ESMTP id E1EEE679EB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Apr 2006 05:59:16 +1000 (EST)
Date: Mon, 17 Apr 2006 16:52:01 -0500
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: David Jander <david.jander@protonic.nl>
Subject: Re: Trouble with 2.6.16 on ppc8xx ?
Message-ID: <20060417215201.GA9548@dmt.cnet>
References: <200604141050.56757.david.jander@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200604141050.56757.david.jander@protonic.nl>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

On Fri, Apr 14, 2006 at 10:50:56AM +0200, David Jander wrote:
> 
> Hi all,
> 
> I just cg-update'd to the HEAD of the denx 2.6.x kernel tree (2.6.16 as 
> released).

Is it a vanilla 2.6.16?

> Our board-support stuff was succesfully moved along from 2.6.14 (when 
> everything but the SCC3 and SCC4 uarts worked just fine).
> I compiled a kernel without any special drivers, just console on ttyCPM0, but 
> after "Uncompressing Kernel Image ... OK" there is no more output and no 
> further activity on ethernet (it should boot from nfs-root) or any other 
> device.
> 
> After "cg-seek DENX-v2.6.15; make clean uImage", it works again (everything 
> seems fine, system boots).
> 
> Our board is based on a MPC852T and until now we used "MPC86X" as the 
> BOARD_CHIP_NAME and it worked just fine with 2.6.14 and 2.6.15, but not with 
> 2.6.16 as described above.
> 
> When doing "cg-diff" and carfully examining it's output, I can only see our 
> board-support stuff (not very much, not very special) and some custom drivers 
> that are disabled anyway.
> 
> Any clue about where to start looking?
> 
> I didn't find any suspicious changes in arch/ppc/mm, arch/ppc/syslib and 
> arch/ppc/kernel. Neither in drivers/serial/cpm_uart.
> 
> Which change from 2.6.15 to 2.6.16 could have broken 8xx support for us?
> 
> Is there perhaps a known issue with 2.6.16 and ppc8xx I am unaware of?

2.6.16 working fine over here... What's your .config?

[root@CAS root]# cat /proc/cpuinfo 
processor       : 0
cpu             : 8xx
clock           : 48MHz
bus clock       : 48MHz
revision        : 0.0 (pvr 0050 0000)
bogomips        : 47.71
[root@CAS root]# uname -a
Linux CAS 2.6.16 #1 Thu Apr 13 11:08:03 PDT 2006 ppc unknown
