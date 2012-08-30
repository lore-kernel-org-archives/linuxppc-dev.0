Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9BB492C0269
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2012 03:19:28 +1000 (EST)
Date: Thu, 30 Aug 2012 10:19:19 -0700
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] clk: Make the generic clock API available by default
Message-ID: <20120830171918.GE4356@opensource.wolfsonmicro.com>
References: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <503E8E6E.1010101@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <503E8E6E.1010101@wwwdotorg.org>
Cc: linux-mips@linux-mips.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Paul Mackerras <paulus@samba.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2012 at 02:49:34PM -0700, Stephen Warren wrote:
> On 08/28/12 13:35, Mark Brown wrote:

> >@@ -674,6 +676,7 @@ config ARCH_TEGRA
> >  	select GENERIC_CLOCKEVENTS
> >  	select GENERIC_GPIO
> >  	select HAVE_CLK
> >+	select HAVE_CUSTOM_CLK

> For 3.7, Tegra will switch to the common clock framework. I think
> this patch would then disable that. How should we resolve this -
> rebase the Tegra common-clk tree on top of any branch containing
> this patch in order to remove that select statement?

I'd expect this to be applied on a separate branch so you should be able
to rebase your conversion on top of it or merge it into your branch
which should deal with things well enough I think?
