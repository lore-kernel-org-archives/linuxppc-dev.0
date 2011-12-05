Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6EFF71007D6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2011 12:02:28 +1100 (EST)
Message-ID: <4EDC0CD5.2090601@zytor.com>
Date: Sun, 04 Dec 2011 16:14:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHv5] atomic: add *_dec_not_zero
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
 <20111204213316.GB14542@n2100.arm.linux.org.uk>
 <1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>
 <20111204221850.GC14542@n2100.arm.linux.org.uk>
 <1323038515.11728.26.camel@pasglop>
In-Reply-To: <1323038515.11728.26.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, Sven Eckelmann <sven@narfation.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Arnd Bergma nn <arnd@arndb.de>, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
 linux-alpha@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
 Tony Luck <tony.luck@intel.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, linux-m32r@ml.linux-m32r.org,
 linux-parisc@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 "David S. Miller" <davem@davemloft.net>, Kyle McMartin <kyle@mcmartin.ca>,
 Richard Weinberger <richard@nod.at>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Hirokazu Takata <takata@linux-m32r.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/04/2011 02:41 PM, Benjamin Herrenschmidt wrote:
> 
> I agree with Russell, his approach is a lot easier to maintain long run,
> we should even consider converting existing definitions.
> 

Thirded.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
