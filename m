Return-Path: <siccegge@faui48a.informatik.uni-erlangen.de>
Received: from faui40.informatik.uni-erlangen.de
	(faui40.informatik.uni-erlangen.de [131.188.34.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B870B7E02
	for <linuxppc-dev@ozlabs.org>; Thu, 13 May 2010 00:40:24 +1000 (EST)
Date: Wed, 12 May 2010 16:40:17 +0200
From: Christoph Egger <siccegge@cs.fau.de>
To: Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Mike Frysinger <vapier@gentoo.org>,
	Graf Yang <graf.yang@analog.com>, Mikael Starvik <starvik@axis.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Chen Liqin <liqin.chen@sunplusct.com>,
	Lennox Wu <lennox.wu@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, Arjan van de Ven <arjan@linux.intel.com>,
	Karsten Keil <isdn@linux-pingi.de>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	"Pekka Savola (ipv6)" <pekkas@netcore.fi>,
	James Morris <jmorris@namei.org>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Patrick McHardy <kaber@trash.net>, Timo Teras <timo.teras@iki.fi>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org, linux-cris-kernel@axis.com,
	linux-ia64@vger.kernel.org, linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Subject: Re: Config Items appearing twice in same Kconfig file?
Message-ID: <20100512144017.GA722@faui48a.informatik.uni-erlangen.de>
References: <20100512143445.GA32559@faui48a.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100512143445.GA32559@faui48a.informatik.uni-erlangen.de>
Cc: vamos@i4.informatik.uni-erlangen.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just noticed it might have been worth adding the output so everyone
out there doesn't ned to grep through his tree for reference:

% grep  ^config **/Kconfig* | sort | uniq -dc                               
      2 arch/alpha/Kconfig.debug:config ALPHA_LEGACY_START_ADDRESS
      2 arch/alpha/Kconfig:config ALPHA_EV4
      3 arch/alpha/Kconfig:config ALPHA_EV56
      2 arch/alpha/Kconfig:config ALPHA_GAMMA
      2 arch/blackfin/Kconfig:config MEM_MT48LC32M8A2_75
      2 arch/cris/arch-v32/drivers/Kconfig:config ETRAX_RS485
      2 arch/cris/arch-v32/drivers/Kconfig:config ETRAX_RS485_DISABLE_RECEIVER
      2 arch/cris/arch-v32/drivers/Kconfig:config ETRAX_SER3_CD_BIT
      2 arch/h8300/Kconfig.ide:config H8300_IDE_ALT
      2 arch/h8300/Kconfig.ide:config H8300_IDE_BASE
      2 arch/h8300/Kconfig.ide:config H8300_IDE_IRQ
      2 arch/ia64/Kconfig:config IOMMU_HELPER
      2 arch/powerpc/Kconfig:config KERNEL_START
      2 arch/powerpc/Kconfig:config PAGE_OFFSET
      2 arch/powerpc/Kconfig:config PHYSICAL_START
      2 arch/powerpc/Kconfig:config RELOCATABLE
      2 arch/score/Kconfig:config RWSEM_GENERIC_SPINLOCK
      4 arch/x86/Kconfig.debug:config DEFAULT_IO_DELAY_TYPE
      2 arch/x86/Kconfig:config PCI_MMCONFIG
      2 arch/x86/Kconfig:config X86_EXTENDED_PLATFORM
      2 drivers/isdn/hisax/Kconfig:config HISAX_AVM_A1_PCMCIA
      2 net/ipv4/Kconfig:config TCP_CONG_CUBIC
