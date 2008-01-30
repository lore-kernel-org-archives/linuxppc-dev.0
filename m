Return-Path: <tony.luck@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by ozlabs.org (Postfix) with ESMTP id 07088DDE9D
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 06:22:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: x86/non-x86: percpu, node ids, apic ids x86.git fixup
Date: Wed, 30 Jan 2008 11:10:51 -0800
Message-ID: <1FE6DD409037234FAB833C420AA843EC757EAF@orsmsx424.amr.corp.intel.com>
In-Reply-To: <20080130184920.GA32212@elte.hu>
References: <200801301414.m0UEEgCC006371@hera.kernel.org>
	<Pine.LNX.4.64.0801301622460.11859@vixen.sonytel.be>
	<47A09F8A.3000309@sgi.com> <20080130161036.GA12293@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757C72@orsmsx424.amr.corp.intel.com>
	<20080130180623.GA24881@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757DEA@orsmsx424.amr.corp.intel.com>
	<20080130184920.GA32212@elte.hu>
From: "Luck, Tony" <tony.luck@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Mike Travis <travis@sgi.com>,
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

> could you try the full patchset that Travis has just sent and which =
i've=20
> put into x86.git, you can pull it from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86.git
>
> it's a fixes only tree, ontop of Linus-very-latest. Head =
4b9e425c25f84.=20
> [pull from ssh://master.kernel.org if it's not on git.kernel.org yet,=20
> uploaded it this very minute.]

Same build fail for CONFIG_SMP=3Dn.  The SMP=3Dy build is good (for =
tiger_defconfig)
and boots ok too.

-Tony
