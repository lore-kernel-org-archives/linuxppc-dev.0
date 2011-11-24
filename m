Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 3D1BA1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 09:09:24 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH-RFC 02/10] lib: add GENERIC_PCI_IOMAP
Date: Thu, 24 Nov 2011 23:07:57 +0100
Message-ID: <1564173.bLjG0I2D2P@wuerfel>
In-Reply-To: <b5a1327dd8bb38f87cba7ae10b308ec3b63de66a.1322163031.git.mst@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
 <b5a1327dd8bb38f87cba7ae10b308ec3b63de66a.1322163031.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org,
 linux-m68k@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
 linux@openrisc.net, Jesse Barnes <jbarnes@virtuousgeek.org>,
 Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>,
 Ralf Baechle <ralf@linux-mips.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Lennox Wu <lennox.wu@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Russell King <linux@arm.linux.org.uk>, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>, linux-sh@vger.kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Arend van Spriel <arend@broadcom.com>, Matt Turner <mattst88@gmail.com>,
 linux-arch@vger.kernel.org, Lasse Collin <lasse.collin@tukaani.org>,
 Lucas De Marchi <lucas.demarchi@profusion.mobi>,
 microblaze-uclinux@itee.uq.edu.au, Michal Simek <monstr@monstr.eu>,
 Rob Herring <rob.herring@calxeda.com>, Mikael Starvik <starvik@axis.com>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Franky Lin <frankyl@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Michael Ellerman <michael@ellerman.id.au>, Paul Bolle <pebolle@tiscali.nl>,
 Tony Luck <tony.luck@intel.com>, linux-cris-kernel@axis.com,
 linux-parisc@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
 Richard Kuo <rkuo@codeaurora.org>, Kyle McMartin <kyle@mcmartin.ca>,
 Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, Fabio Baltieri <fabio.baltieri@gmail.com>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 24 November 2011 22:17:02 Michael S. Tsirkin wrote:
> Many architectures want a generic pci_iomap but
> not the rest of iomap.c. Split that to a separate .c
> file and add a new config symbol. select automatically
> by GENERIC_IOMAP.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Very nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>
