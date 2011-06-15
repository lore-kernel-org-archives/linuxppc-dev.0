Return-Path: <groeck@ericsson.com>
Received: from imr3.ericy.com (imr3.ericy.com [198.24.6.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 672FAB6F9E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jun 2011 00:46:30 +1000 (EST)
Date: Wed, 15 Jun 2011 07:36:34 -0700
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Message-ID: <20110615143634.GA12757@ericsson.com>
References: <20110614190850.GA13526@linux-mips.org>
	<4DF7C3CA.9050902@zytor.com>
	<20110614223404.GA30057@linux-mips.org>
	<4DF8329C.7000904@zytor.com>
	<20110615083437.GA32624@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110615083437.GA32624@linux-mips.org>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Russell King <linux@arm.linux.org.uk>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Helge Deller <deller@gmx.de>, "x86@kernel.org" <x86@kernel.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
	"microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>,
	Chris Metcalf <cmetcalf@tilera.com>, Mikael Starvik <starvik@axis.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
	Tony Luck <tony.luck@intel.com>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Kyle McMartin <kyle@mcmartin.ca>, Paul Mundt <lethal@linux-sh.org>,
	"linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 15, 2011 at 04:34:37AM -0400, Ralf Baechle wrote:
> On Tue, Jun 14, 2011 at 09:18:36PM -0700, H. Peter Anvin wrote:
> 
> > On 06/14/2011 03:34 PM, Ralf Baechle wrote:
> > > 
> > > There is no point in offering to build something that couldn't possibly be
> > > used.  It just makes the kernel harder to configure and inflates the test
> > > matrix for no good reason.
> > > 
> > 
> > I see... that's why a bunch of devices that only exist on ARM and MIPS
> > SoCs are offered on x86 platforms?
> 
> Well, if you notice one of those, yell.  Or send patches.  Most of those
> have been fixed.
> 
I think he was being sarcastic, and wanted to say that it should be that way.

Guenter
