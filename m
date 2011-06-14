Return-Path: <tony.luck@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by ozlabs.org (Postfix) with ESMTP id A96BCB6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jun 2011 08:18:37 +1000 (EST)
From: "Luck, Tony" <tony.luck@intel.com>
To: Ralf Baechle <ralf@linux-mips.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Chen Liqin <liqin.chen@sunplusct.com>, Chris
	Metcalf <cmetcalf@tilera.com>, Chris Zankel <chris@zankel.net>, "David S.
	Miller" <davem@davemloft.net>, "Yu, Fenghua" <fenghua.yu@intel.com>, Geert
	Uytterhoeven <geert@linux-m68k.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
	Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, "James E.J.
	Bottomley" <jejb@parisc-linux.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Kyle McMartin <kyle@mcmartin.ca>, Lennox Wu <lennox.wu@gmail.com>, Matt
	Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>,
	Mikael Starvik
	<starvik@axis.com>, Paul Mackerras <paulus@samba.org>, Paul Mundt
	<lethal@linux-sh.org>, Richard Henderson <rth@twiddle.net>, Russell King
	<linux@arm.linux.org.uk>, "sparclinux@vger.kernel.org"
	<sparclinux@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>, Yoshinori Sato
	<ysato@users.sourceforge.jp>
Date: Tue, 14 Jun 2011 15:08:37 -0700
Subject: RE: [RFC,PATCH] Cleanup PC parallel port Kconfig
Message-ID: <987664A83D2D224EAE907B061CE93D5301E7281306@orsmsx505.amr.corp.intel.com>
References: <20110614190850.GA13526@linux-mips.org>
In-Reply-To: <20110614190850.GA13526@linux-mips.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 38280ef..849805a 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -23,6 +23,7 @@ config IA64
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DMA_API_DEBUG
 	select HAVE_GENERIC_HARDIRQS
+	select HAVE_PC_PARPORT
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PENDING_IRQ if SMP
 	select IRQ_PER_CPU

I took a look at the back of all my ia64 systems - none of them
have a parallel port.  It seems unlikely that new systems will
start adding parallel ports :-)

So even if I had a printer (or other device) that used a parallel
port, I have no way to test it.

-Tony
