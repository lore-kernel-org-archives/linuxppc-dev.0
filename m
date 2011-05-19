Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 359BAB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 13:33:19 +1000 (EST)
Subject: Re: [PATCH] lib: Consolidate DEBUG_STACK_USAGE option
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Boyd <sboyd@codeaurora.org>
In-Reply-To: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
References: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 13:32:07 +1000
Message-ID: <1305775927.7481.31.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	linux-m32r@ml.linux-m32r.org, user-mode-linux-devel@lists.sourceforge.net,
	linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	Chris Metcalf <cmetcalf@tilera.com>, sparclinux@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-05-06 at 22:57 -0700, Stephen Boyd wrote:
> Most arches define CONFIG_DEBUG_STACK_USAGE exactly the same way.
> Move it to lib/Kconfig.debug so each arch doesn't have to define
> it. This obviously makes the option generic, but that's fine
> because the config is already used in generic code.
> 
> It's not obvious to me that sysrq-P actually does anything
> different with this option enabled, but I erred on the side of
> caution by keeping the most inclusive wording.

Sorry for the delay...

For powerpc:

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.
