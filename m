Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrf2r09F1zDqF6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 03:00:35 +1000 (AEST)
Date: Fri, 15 Jul 2016 18:20:45 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Anton Blanchard <anton@samba.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, rt@linutronix.de,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch V2 30/67] powerpc/numa: Convert to hotplug state machine
Message-ID: <20160715162045.GE16938@linutronix.de>
References: <20160713153219.128052238@linutronix.de>
 <20160713153335.369278769@linutronix.de>
 <20160715074257.7801cd00@kryten>
 <9e878731c9b447ee5e8318237822c492@www.linutronix.de>
 <20160715102825.34d60395@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160715102825.34d60395@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Anton Blanchard | 2016-07-15 10:28:25 [+1000]:

>Hi Anna-Maria,
Hi Anton,

>> >> Install the callbacks via the state machine and let the core invoke
>> >> the callbacks on the already online CPUs. =20
>> >
>> > This is causing an oops on ppc64le QEMU, looks like a NULL
>> > pointer: =20
>>=20
>> Did you tested it against tip WIP.hotplug?
>
>I noticed tip started failing in my CI environment which tests on QEMU.
>The failure bisected to commit 425209e0abaf2c6e3a90ce4fedb935c10652bf80
>
>It reproduces running ppc64le QEMU on a x86-64 box. On Ubuntu:
=E2=80=A6

Thanks for that. I can reproduce this ontop of latest WIP.hotplug with
this patch.

>Anton

Sebastian
