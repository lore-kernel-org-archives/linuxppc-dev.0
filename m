Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id A18BD67BB3
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Oct 2006 01:33:48 +1000 (EST)
Message-ID: <45437856.5060509@ru.mvista.com>
Date: Sat, 28 Oct 2006 19:33:42 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH -rt] powerpc update
References: <20061003155358.756788000@dwalker1.mvista.com>
	<20061018072858.GA29576@elte.hu> <454371AC.4030902@ru.mvista.com>
In-Reply-To: <454371AC.4030902@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
	tglx@linutronix.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

> 3. Do the same as x86 APIC driver does and use level/egde flows instead 
> of fasteoi for the case when IRQs are threaded -- that ensues doing (2) 
> as well.

    Note that OpenPIC (as far as I could understand its h/w) is essentially
the same as IOAPIC/LAPIC couple on x86, i.e. a level-triggered IRQ remains 
effectively globally masked until CPU writes to its local EOI reg. However, 
the repetitive edge-triggered IRQ from the same line may still be detected 
while being serviced on a CPU (hm, the questions is, can it be sent to any 
other CPU in system while being handled on a certain CPU?)...
    I hope somebody corrects me if I'm wrong about both x86 and PPC. :-)

>>     Ingo

WBR, Sergei
