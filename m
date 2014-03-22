Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5F4C02C0079
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Mar 2014 09:04:02 +1100 (EST)
Date: Sat, 22 Mar 2014 23:03:49 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [RESEND][PATCH 1/2] lib/scatterlist: Make ARCH_HAS_SG_CHAIN an
 actual Kconfig
In-Reply-To: <1395523881.2143.58.camel@dabdike.int.hansenpartnership.com>
Message-ID: <alpine.DEB.2.02.1403222302510.18573@ionos.tec.linutronix.de>
References: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
 <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
 <1395523881.2143.58.camel@dabdike.int.hansenpartnership.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>, Russell King <linux@arm.linux.org.uk>,
 linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 linux390@de.ibm.com, sparclinux@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Laura Abbott <lauraa@codeaurora.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 22 Mar 2014, James Bottomley wrote:

> On Sat, 2014-03-22 at 11:13 -0700, Laura Abbott wrote:
> > Rather than have architectures #define ARCH_HAS_SG_CHAIN in an architecture
> > specific scatterlist.h, make it a proper Kconfig option and use that
> > instead. At same time, remove the header files are are now mostly
> > useless and just include asm-generic/scatterlist.h.
> 
> Well, the transformation looks fine.  Perhaps part of the reason for the
> lack of response is that there's no compelling reason in the change log
> above for doing this.  The usual reason for eliminating ARCH_HAS is that
> it's hiding something that would be better expressed a different way
> (that's actually intuitive to grep) or that it's expressing something
> that should be configurable.  Neither of these reasons apply in this
> case, because SG_CHAIN definitely is a property of the architecture not
> the config space and it's not really hiding anything.

Getting rid of pointless copied code is definitely a good enough
reason and the patch removes quite some of that.
 
Thanks,

	tglx
