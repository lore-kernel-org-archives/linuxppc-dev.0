Return-Path: <Maciej.Rozycki@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 159C01A0E27
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2016 00:39:03 +1100 (AEDT)
Date: Fri, 29 Jan 2016 13:38:59 +0000
From: "Maciej W. Rozycki" <macro@imgtec.com>
To: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC: <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, Peter
 Zijlstra <peterz@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>,
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
 <linux-xtensa@linux-xtensa.org>, <xen-devel@lists.xenproject.org>, Ralf
 Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>,
 <ddaney.cavm@gmail.com>, <james.hogan@imgtec.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <56A9656D.3080707@imgtec.com>
Message-ID: <alpine.DEB.2.00.1601291333130.5958@tp.orcam.me.uk>
References: <20160113104516.GE25458@arm.com> <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com> <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com> <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <569814F2.50801@imgtec.com> <20160114225510.GJ3818@linux.vnet.ibm.com>
 <56983054.4070807@imgtec.com> <20160115004753.GN3818@linux.vnet.ibm.com>
 <56984642.3090106@imgtec.com>
 <alpine.DEB.2.00.1601271116520.5958@tp.orcam.me.uk>
 <56A9656D.3080707@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 28 Jan 2016, Leonid Yegoshin wrote:

> In http://patchwork.linux-mips.org/patch/10505/ the very last mesg exchange
> is:
[...]
> ... and that stops forever...

 Thanks for the reminder -- last June was very hectic, I travelled a lot 
and I lost the discussion from my radar.  Apologies for that.  I replied 
in that thread now with my results.  I hope this helps.

  Maciej
