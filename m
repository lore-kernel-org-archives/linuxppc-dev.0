Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8CAF4DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 20:00:35 +1000 (EST)
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by fallback.mail.elte.hu with esmtp (Exim) id 1K6N82-0006qm-24
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 12:00:30 +0200
Date: Wed, 11 Jun 2008 11:59:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: powerpc build failure
Message-ID: <20080611095951.GB14033@elte.hu>
References: <20080611192748.686236fd.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080611192748.686236fd.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next build (powerpc allyesconfig) failed like this:
> 
> vmlinux.o: In function `ipx_ioctl':
> /scratch/sfr/next/net/ipx/af_ipx.c:1830: relocation truncated to fit: R_PPC64_REL24 against symbol `._mcount' defined in .text section in vmlinux.o
> 
> (and lots more similar)
> 
> I am assuming that this has something to do with how big vmlinux is 
> for allyesconfig and the addition of -pg to KBUILD_CFLAGS for ftrace.

could this be a tool chain limitation perhaps, or a gcc bug? Or does the 
allyesconfig size go beyond some fundamental hardware limitation. (i 
doubt it's the latter)

	Ingo
