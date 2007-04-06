Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7FEF4DDEC1
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Apr 2007 01:42:54 +1000 (EST)
Date: Fri, 6 Apr 2007 19:42:52 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Bruce_Leonard@selinc.com
Subject: Re: Unable to boot kernel on MPC8349ITX eval board
Message-ID: <20070406194252.2a647d9f@vitb.ru.mvista.com>
In-Reply-To: <OFCBEB6783.BEA8A149-ON882572B4.0065E63D-882572B4.0065ED92@selinc.com>
References: <OFCBEB6783.BEA8A149-ON882572B4.0065E63D-882572B4.0065ED92@selinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 5 Apr 2007 11:33:19 -0700
Bruce_Leonard@selinc.com wrote:

> Modules linked in:
> NIP: 0FE741B0 LR: 0FE76464 CTR: 00000000
> REGS: c0001f50 TRAP: 0301   Not tainted  (2.6.20.4)
> MSR: 0000D032 <EE,PR,ME,IR,DR>  CR: 00000000  XER: 00000000
> DAR: 7F9A26C8, DSISR: 20000000
> TASK = c0656030[865] 'udevd' THREAD: cfb00000
> GPR00: 00000019 7F99E6A0 30023290 100155F8 000028D8 0FE76464 00000019 
> 0FF521C0
> GPR08: 100155F8 3D407265 FFFFFFD0 00000000 22004442
> NIP [0FE741B0] 0xfe741b0
> LR [0FE76464] 0xfe76464
> Call Trace:
>  <0>Kernel panic - not syncing: Fatal exception in interrupt
>  <0>Rebooting in 180 seconds..
You should build the kernel with debugging enabled - to extract what
kernel module caused the oops.
Try to disable that "[ ok ]rting kernel event manager..." service, look up what script says 
"* Loading hardware drivers..." 
and make it tell what exactly it tries to insmod.

Also, you can use any other ppc root (eldk, freescale, buildroot etc...)

-- 
Sincerely, 
Vitaly
