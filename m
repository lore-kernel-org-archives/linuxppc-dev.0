Return-Path: <anna-maria@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrCQ33xPlzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 10:00:43 +1000 (AEST)
To: Anton Blanchard <anton@samba.org>
Subject: Re: [patch V2 30/67] powerpc/numa: Convert to hotplug state machine
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 15 Jul 2016 01:37:15 +0200
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, <rt@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Bharata B Rao
 <bharata@linux.vnet.ibm.com>, Christophe Jaillet
 <christophe.jaillet@wanadoo.fr>, Linus Torvalds
 <torvalds@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@samba.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 <linuxppc-dev@lists.ozlabs.org>
In-Reply-To: <20160715074257.7801cd00@kryten>
References: <20160713153219.128052238@linutronix.de>
 <20160713153335.369278769@linutronix.de> <20160715074257.7801cd00@kryten>
Message-ID: <9e878731c9b447ee5e8318237822c492@www.linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 2016-07-14 23:42, Anton Blanchard wrote:
> Hi,
>
>> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> Install the callbacks via the state machine and let the core invoke
>> the callbacks on the already online CPUs.
>
> This is causing an oops on ppc64le QEMU, looks like a NULL pointer:

Did you tested it against tip WIP.hotplug?

Regards,
      Anna-Maria
