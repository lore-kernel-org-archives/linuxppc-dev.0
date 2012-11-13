Return-Path: <tony.luck@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by ozlabs.org (Postfix) with ESMTP id D55482C0093
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2012 08:28:14 +1100 (EST)
From: "Luck, Tony" <tony.luck@intel.com>
To: James Hogan <james.hogan@imgtec.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] arch Kconfig: remove references to IRQ_PER_CPU
Date: Tue, 13 Nov 2012 21:28:11 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F19D5F453@ORSMSX108.amr.corp.intel.com>
References: <1352807948-26920-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1352807948-26920-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, "James
 E.J. Bottomley" <jejb@parisc-linux.org>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, Richard Kuo <rkuo@codeaurora.org>,
 Paul Mundt <lethal@linux-sh.org>, Mike Frysinger <vapier@gentoo.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 "uclinux-dist-devel@blackfin.uclinux.org"
 <uclinux-dist-devel@blackfin.uclinux.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> But IRQ_PER_CPU wasn't removed from any of the architecture Kconfig
> files where it was defined or selected. It's completely unused so remove
> the remaining references.

Acked-by: Tony Luck <tony.luck@intel.com>

[Hope someone picks up this whole patch ... otherwise I can take the ia64 h=
unk]
