Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C58A8B7D01
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Feb 2010 16:18:14 +1100 (EST)
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim) id 1Nehdp-0000Eu-Iz
	from <mingo@elte.hu>
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Feb 2010 05:24:01 +0100
Date: Tue, 9 Feb 2010 05:22:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: tip build problem on powerpc
Message-ID: <20100209042238.GB11280@elte.hu>
References: <20100209100700.81685ffe.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100209100700.81685ffe.sfr@canb.auug.org.au>
Cc: Peter Zijlstra <peterz@infradead.org>, Don Zickus <dzickus@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Last night's build of tip/master on powerpc produced these errors:
> 
> kernel/nmi_watchdog.c:33: error: redefinition of 'touch_nmi_watchdog'
> kernel/nmi_watchdog.c:59: error: 'nmi_watchdog_enabled' undeclared (first use in this function)
> kernel/nmi_watchdog.c:59: error: (Each undeclared identifier is reported only once
> kernel/nmi_watchdog.c:59: error: for each function it appears in.)
> kernel/nmi_watchdog.c:109: error: implicit declaration of function 'die_nmi'
> kernel/nmi_watchdog.c:136: error: 'cpu_khz' undeclared (first use in this function)

yep, i know that already from the -tip cross build tests and reported it to 
Don yesterday. Do you boot -tip or only build test it? If you use -tip 
personally then you can simply disable CONFIG_NMI_WATCHDOG.

Thanks,

	Ingo
