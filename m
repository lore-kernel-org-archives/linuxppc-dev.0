Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D40F4DDF22
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 03:18:10 +1100 (EST)
Date: Wed, 30 Jan 2008 17:10:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mike Travis <travis@sgi.com>
Subject: Re: x86/non-x86: percpu, node ids, apic ids x86.git fixup
Message-ID: <20080130161036.GA12293@elte.hu>
References: <200801301414.m0UEEgCC006371@hera.kernel.org>
	<Pine.LNX.4.64.0801301622460.11859@vixen.sonytel.be>
	<47A09F8A.3000309@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47A09F8A.3000309@sgi.com>
Cc: sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Mike Travis <travis@sgi.com> wrote:

> > This broke powerpc (and presumably ia64 and sparc64) in current 
> > linux-2.6.git:
> 
> I'm generating a "fixup patch" right now...

thanks! Sorry about that: we cross-built on ARM but not on SMP non-x86 
platforms so this dependency/breakage went unnoticed.

	Ingo
