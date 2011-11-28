Return-Path: <rkuo@codeaurora.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "wolverine01.qualcomm.com",
 Issuer "VeriSign Class 3 Secure Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F16611007D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 07:22:46 +1100 (EST)
Date: Mon, 28 Nov 2011 14:12:26 -0600
From: Richard Kuo <rkuo@codeaurora.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH-RFC 01/10] lib: move GENERIC_IOMAP to lib/Kconfig
Message-ID: <20111128201226.GA4296@codeaurora.org>
References: <cover.1322163031.git.mst@redhat.com>
 <5aed7b7e1dbc8a50ebd6986245df8054fd05b7cd.1322163031.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5aed7b7e1dbc8a50ebd6986245df8054fd05b7cd.1322163031.git.mst@redhat.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org,
 linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, linux@openrisc.net, linux-pci@vger.kernel.org,
 Jesse Barnes <jbarnes@virtuousgeek.org>, Chen Liqin <liqin.chen@sunplusct.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Lennox Wu <lennox.wu@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Russell King <linux@arm.linux.org.uk>, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-arch@vger.kernel.org,
 Arend van Spriel <arend@broadcom.com>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Lasse Collin <lasse.collin@tukaani.org>,
 Arnd Bergmann <arnd@arndb.de>, Lucas De Marchi <lucas.demarchi@profusion.mobi>,
 microblaze-uclinux@itee.uq.edu.au, Paul Bolle <pebolle@tiscali.nl>,
 Rob Herring <rob.herring@calxeda.com>, Mikael Starvik <starvik@axis.com>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Franky Lin <frankyl@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Fabio Baltieri <fabio.baltieri@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Michael Ellerman <michael@ellerman.id.au>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, Paul Gortmaker <paul.gortmaker@windriver.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Kyle McMartin <kyle@mcmartin.ca>, Paul Mundt <lethal@linux-sh.org>,
 linux-alpha@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 24, 2011 at 10:15:42PM +0200, Michael S. Tsirkin wrote:
> define GENERIC_IOMAP in a central location
> instead of all architectures. This will be helpful
> for the follow-up patch which makes it select
> other configs. Code is also a bit shorter this way.

For the Hexagon config,

Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
