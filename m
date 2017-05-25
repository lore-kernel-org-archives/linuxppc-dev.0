Return-Path: <kda@linux-powerpc.org>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYSDP4D35zDqjr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 21:47:16 +1000 (AEST)
Received: by mail-pf0-x234.google.com with SMTP id 9so165062706pfj.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 04:47:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1495709619.27765.11.camel@abdul.in.ibm.com>
References: <1490612559.8344.15.camel@abdul.in.ibm.com>
 <871sthbu12.fsf@concordia.ellerman.id.au>
 <1491209923.7788.9.camel@abdul.in.ibm.com>
 <1491210231.7788.12.camel@abdul.in.ibm.com>
 <1495521199.9020.13.camel@abdul.in.ibm.com>
 <87mva2a2yb.fsf@concordia.ellerman.id.au>
 <1495709619.27765.11.camel@abdul.in.ibm.com>
From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Thu, 25 May 2017 14:47:13 +0300
Message-ID: <CAOJe8K11QpxvKgcUVtPxO6dd_qKTFp8gbPdpaseiCGeUXs2gow@mail.gmail.com>
Subject: Re: [PowerPC][next-20170324][kselftest] kernel Oops when running
 tm/tm-signal-context-chk-vsx
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, sachinp <sachinp@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Cyril Bur <cyrilbur@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[  283.516559] Kernel BUG at c00000000191c160 [verbose debug info unavailable]
[  283.516573] Unexpected TM Bad Thing exception at c00000000191c160
(msr 0x2a03030)
cpu 0x19: Vector: 700 (Program Check) at [c0000007d1a37920]
    pc: c00000000191c160: fast_exception_return+0xac/0xb4
    lr: c000000001925ed4: .arch_local_irq_restore.part.10+0x74/0xa0
    sp: c0000007d1a37ba0
   msr: 9000000302a03030
  current = 0xc0000007d094c000
  paca    = 0xc00000000fffd980	 softe: 0	 irq_happened: 0x01
    pid   = 7804, comm = tm-signal-conte
Linux version 4.12.0-rc2 (root@power.oil.ru) (gcc version 4.8.3
20140911 (Red Hat 4.8.3-9) (GCC) ) #31 SMP PREEMPT Thu May 25 07:22:54
EDT 2017
WARNING: exception is not recoverable, can't continue
enter ? for help
[link register   ] c000000001925ed4 .arch_local_irq_restore.part.10+0x74/0xa0
[c0000007d1a37ba0] c000000001925ea0
.arch_local_irq_restore.part.10+0x40/0xa0 (unreliable)
[c0000007d1a37c10] c000000001a565f0 .lock_acquire+0x100/0x340
[c0000007d1a37cf0] c000000001b8fb44 .__might_fault+0x74/0xb0
[c0000007d1a37d60] c00000000193cd60 .sys_rt_sigreturn+0x9e0/0xb70
[c0000007d1a37e30] c00000000191b9ec system_call+0x38/0xfc
--- Exception: c01 (System Call) at 0000000010001c38
SP (7fffddb2dd60) is in userspace

>
>
>
>
