Return-Path: <Leonid.Yegoshin@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 8AF481A0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 11:58:47 +1100 (AEDT)
Message-ID: <56A967BF.70200@imgtec.com>
Date: Wed, 27 Jan 2016 16:58:39 -0800
From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@imgtec.com>
CC: <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 <linux-arch@vger.kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 <virtualization@lists.linux-foundation.org>, Stefano Stabellini
 <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches
 <joe@perches.com>, David Miller <davem@davemloft.net>,
 <linux-ia64@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-s390@vger.kernel.org>, <sparclinux@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-metag@vger.kernel.org>,
 <linux-mips@linux-mips.org>, <x86@kernel.org>,
 <user-mode-linux-devel@lists.sourceforge.net>,
 <adi-buildroot-devel@lists.sourceforge.net>, <linux-sh@vger.kernel.org>,
 <linux-xtensa@linux-xtensa.org>, <xen-devel@lists.xenproject.org>, "Ralf
 Baechle" <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>,
 <ddaney.cavm@gmail.com>, <james.hogan@imgtec.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
References: <20160113104516.GE25458@arm.com> <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com> <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com> <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com> <569814F2.50801@imgtec.com>
 <20160114225510.GJ3818@linux.vnet.ibm.com> <56983054.4070807@imgtec.com>
 <20160115004753.GN3818@linux.vnet.ibm.com> <56984642.3090106@imgtec.com>
 <alpine.DEB.2.00.1601271116520.5958@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.00.1601271116520.5958@tp.orcam.me.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/27/2016 03:26 AM, Maciej W. Rozycki wrote:
> On Fri, 15 Jan 2016, Leonid Yegoshin wrote:
>
>>> So you need to build a different kernel for some types of MIPS systems?
>>> Or do you do boot-time rewriting, like a number of other arches do?
>> I don't know. I would like to have responses. Ralf asked Maciej about old
>> systems and that came nowhere. Even rewrite - don't know what to do with that:
>> no lightweight SYNC or no SYNC at all - yes, it is still possible that SYNC on
>> some systems can be too heavy or even harmful, nobody tested that.
>   I don't recall being asked; mind that I might not get to messages I have
> not been cc-ed in a timely manner and I may miss some altogether.  With
> the amount of mailing list traffic that passes by me my scanner may fail
> to trigger.  Sorry if this causes anybody trouble, but such is life.
>
>   Coincidentally, I have just posted some notes on SYNC in a different
> thread, see <http://lkml.iu.edu/hypermail/linux/kernel/1601.3/03080.html>.
> There's a reference to an older message of mine there too.  I hope this
> answers your questions.
>
>    Maciej
In http://patchwork.linux-mips.org/patch/10505/the very last mesg 
exchange is:

Maciej,

do you have an R4000 / R4600 / R5000 / R7000 / SiByte system at hand to
test this?
...
   Ralf

Maciej W. Rozycki- June 5, 2015, 9:18 p.m.

On Fri, 5 Jun 2015, Ralf Baechle wrote:

> do you have an R4000 / R4600 / R5000 / R7000 / SiByte system at hand to
> test this?

  I should be able to check R4400 (that is virtually the same as R4000)
next week or so.  As to SiByte -- not before next month I'm afraid.  I
don't have access to any of the other processors you named.  You may
want to find a better person if you want to accept this change soon.

   Maciej

... and that stops forever...

- Leonid.
