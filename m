Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.183])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tvNwQ66LRzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 21:20:05 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Dmitry Safonov' <dsafonov@virtuozzo.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
CC: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Peter Zijlstra
 <peterz@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Paul
 Mackerras" <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Helge Deller
 <deller@gmx.de>, "x86@kernel.org" <x86@kernel.org>, "James E.J. Bottomley"
 <jejb@parisc-linux.org>, Will Deacon <will.deacon@arm.com>, Ingo Molnar
 <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>, Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-parisc@vger.kernel.org"
 <linux-parisc@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, "Martin
 Schwidefsky" <schwidefsky@de.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: RE: [RFC 1/4] mm: remove unused TASK_SIZE_OF()
Date: Thu, 5 Jan 2017 09:51:26 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0258289@AcuExch.aculab.com>
References: <20161230155634.8692-1-dsafonov@virtuozzo.com>
 <20161230155634.8692-2-dsafonov@virtuozzo.com>
In-Reply-To: <20161230155634.8692-2-dsafonov@virtuozzo.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dmitry Safonov
> Sent: 30 December 2016 15:57
> All users of TASK_SIZE_OF(tsk) have migrated to mm->task_size or
> TASK_SIZE_MAX since:
> commit d696ca016d57 ("x86/fsgsbase/64: Use TASK_SIZE_MAX for
> FSBASE/GSBASE upper limits"),
> commit a06db751c321 ("pagemap: check permissions and capabilities at
> open time"),
...
> +#define TASK_SIZE	        (current->thread.task_size)

I'm not sure I like he hidden 'current' argument to an
apparent constant.

	David
