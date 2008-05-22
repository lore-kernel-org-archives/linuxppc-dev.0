Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77A2EDE100
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 May 2008 00:19:22 +1000 (EST)
Message-Id: <F6DD85B3-8DBE-4753-872A-B204BAFF7862@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: sandeep malik <malik_mca2000@yahoo.co.in>
In-Reply-To: <759615.89060.qm@web8413.mail.in.yahoo.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Help needed in debugging the crash  of kernel stack overflow
Date: Thu, 22 May 2008 09:19:15 -0500
References: <759615.89060.qm@web8413.mail.in.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On May 22, 2008, at 8:08 AM, sandeep malik wrote:

> Hi,
>
> We are using MSC7120 (e300 based) board running Montavista Linux  
> 2.4. We are observing a random crash with the following dump:
>
> Kernel stack overflow in process c5b22000, r1=c5b22460
> NIP: 00000000 XER: 20000000 LR: 00000000 SP: C5B22460 REGS: c5b223b0  
> TRAP: 0400    Tainted: P
> MSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c5b22000[175] 'insmod' Last syscall: -1
> last math 00000000 last altivec 00000000
> GPR00: 00000000 C5B22460 C5B22000 C5B22470 00000000 20001032  
> 00000000 00000000
> GPR08: F0000700 00000000 00000008 00000001 24224482 1033BB30  
> 00000000 00000000
> GPR16: 00000000 00000000 00000000 00000001 00001032 05B22460  
> 00000000 00000000
> GPR24: 00000000 00000200 C7B09400 C016A240 C5B23D80 00000010  
> 00000000 C7B09400
> Call backtrace:
> 70536574 34205220 00000000 00000000 00000000 55555555 55555555
> 55555555 55555555 55555555 55515555 55555555 55555555 55515555
> 55555555 55555555 494C450A 66363531 4F4E455F 35382054 38383053
> 20542056 43686563 53797353 35632052 70383830 74205670 0A636230
> 436D640A 38383053 24108028 C5C740C8 C00059AC
> Kernel panic: kernel stack overflow
> In interrupt handler - not syncing
>
> Any idea what might be going wrong or how to approach this problem  
> as it is not getting reproduced and the behaviour is very random.  
> Any pointers will be helpful.

You really need to take these up with MontaVista.

- k
