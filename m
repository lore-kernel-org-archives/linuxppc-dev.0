Return-Path: <elendil@planet.nl>
Received: from CPSMTPM-EML109.kpnxchange.com (Cpsmtpm-eml109.kpnxchange.com
	[195.121.3.13]) by ozlabs.org (Postfix) with ESMTP id B0743B7D02
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Feb 2010 04:56:54 +1100 (EST)
From: Frans Pop <elendil@planet.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 00/16] remove trailing spaces in messages
Date: Sat, 6 Feb 2010 18:44:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201002061844.45212.elendil@planet.nl>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Helge Deller <deller@gmx.de>, x86@kernel.org,
	Ingo Molnar <mingo@elte.hu>, Fenghua Yu <fenghua.yu@intel.com>,
	Mike Frysinger <vapier@gentoo.org>,
	user-mode-linux-devel@lists.sourceforge.net,
	microblaze-uclinux@itee.uq.edu.au, Jeff Dike <jdike@addtoit.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-m68k@lists.linux-m68k.org,
	linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
	Jiri Kosina <trivial@kernel.org>, linux-cris-kernel@axis.com,
	linux-parisc@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Kyle McMartin <kyle@mcmartin.ca>, linux-alpha@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a first series of patches to remove trailing spaces in messages. 
Patches cover arch-specific code plus one fix for PM and one in 
Documentation. Depending on how this series is received I'll continue
with other parts of the kernel.

Benefits are:
- general cleanup and consistency
- minor reduction in kernel size and user's log file size
- reduced annoyance for people writing logcheck rules

The patch for m68k has been rebased against linux-next; all other
patches apply against both mainline and -next (as of 5-2).

Shortstat:
 74 files changed, 135 insertions(+), 136 deletions(-)

Frans Pop (16):
      alpha: remove trailing spaces in messages
      arm: remove trailing spaces in messages
      ia64: remove trailing space in messages
      m68k: remove trailing space in messages
      microblaze: remove trailing space in messages
      mips: remove trailing space in messages
      parisc: remove trailing space in messages
      s390: remove trailing space in messages
      sparc: remove trailing space in messages
      x86: remove trailing space in messages
      blackfin: remove trailing space in messages
      cris/trivial: remove trailing space in message
      powerpc: remove trailing space in messages
      um: remove trailing space in messages
      PM: remove trailing space in message
      trivial: remove trailing space in spidev test program
