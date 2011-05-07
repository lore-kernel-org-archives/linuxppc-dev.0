Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 1D9FAB6FDC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 May 2011 17:59:23 +1000 (EST)
Date: Sat, 07 May 2011 00:58:48 -0700 (PDT)
Message-Id: <20110507.005848.226775736.davem@davemloft.net>
To: sboyd@codeaurora.org
Subject: Re: [PATCH] lib: Consolidate DEBUG_STACK_USAGE option
From: David Miller <davem@davemloft.net>
In-Reply-To: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
References: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	linux-m32r@ml.linux-m32r.org, user-mode-linux-devel@lists.sourceforge.net,
	linux-sh@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	sparclinux@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stephen Boyd <sboyd@codeaurora.org>
Date: Fri,  6 May 2011 22:57:11 -0700

> Most arches define CONFIG_DEBUG_STACK_USAGE exactly the same way.
> Move it to lib/Kconfig.debug so each arch doesn't have to define
> it. This obviously makes the option generic, but that's fine
> because the config is already used in generic code.
> 
> It's not obvious to me that sysrq-P actually does anything
> different with this option enabled, but I erred on the side of
> caution by keeping the most inclusive wording.
> 
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: uclinux-dist-devel@blackfin.uclinux.org
> Cc: linux-m32r@ml.linux-m32r.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: user-mode-linux-devel@lists.sourceforge.net
> Cc: x86@kernel.org
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: David S. Miller <davem@davemloft.net>
