Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 407311007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 02:03:53 +1000 (EST)
Date: Wed, 6 Apr 2011 11:03:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: Justin Mattock <justinmattock@gmail.com>
Subject: Re: [RFC 2/5]arch:powerpc:sysdev:Makefile Remove unused config in
	the Makefile.
Message-ID: <20110406110335.0f2d5f4c@schlenkerla.am.freescale.net>
In-Reply-To: <BANLkTi=5A1P-WAFvCyjbT7RVva9K9d=gQQ@mail.gmail.com>
References: <1302022702-24541-1-git-send-email-justinmattock@gmail.com>
	<1302022702-24541-2-git-send-email-justinmattock@gmail.com>
	<20110405131504.1d182da4@schlenkerla.am.freescale.net>
	<BANLkTi=5A1P-WAFvCyjbT7RVva9K9d=gQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, trivial@kernel.org,
	linux-kernel@vger.kernel.org, Harninder Rai <harninder.rai@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 6 Apr 2011 08:07:58 -0700
Justin Mattock <justinmattock@gmail.com> wrote:

> ahh.. so the:  fsl_85xx_l2ctlr.o fsl_85xx_cache_sram.o is still in use
> even though FSL_85XX_CACHE_SRAM is not really used, but really is used!!
> 
> but might be wrong with this.

More like there are plans to use it, or possibly out-of-tree users.  We
should prod people a bit to submit the driver patches that use this before
we just yank it out.

-Scott
