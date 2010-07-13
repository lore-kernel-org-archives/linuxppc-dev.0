Return-Path: <dwalker@codeaurora.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wolverine02.qualcomm.com",
	Issuer "VeriSign Class 3 Secure Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9E05AB6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Jul 2010 09:27:23 +1000 (EST)
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
From: Daniel Walker <dwalker@codeaurora.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20100713230352.6781.18644.stgit@angua>
References: <20100713230352.6781.18644.stgit@angua>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Jul 2010 16:14:41 -0700
Message-ID: <1279062881.4609.34.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Cc: linux-kbuild@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-07-13 at 17:04 -0600, Grant Likely wrote:

> - I haven't figured out a way for the fragment to force an option to
>   be "n", or to set a value, for example "CONFIG_LOG_BUF_SHIFT=16".
>   This may require changing the syntax.
> - It still doesn't resolve dependencies.  A solver would help with this.
>   For the time being I work around the problem by running the generated
>   config through 'oldconfig' and looking for differences.  If the files
>   differ (ignoring comments and generateconfig_* options) after oldconfig,
>   then the <board>_defconfig target returns a failure.  (but leaves the
>   new .config intact so the user can resolve it with menuconfig).  This
>   way at least the user is told when a Kconfig fragment is invalid.

The solver would fix the whole issues with the defconfigs , we wouldn't
need this Kconfig change .. From my perspective we shouldn't be fooling
around with anything but the solver approach ..

It just doesn't feel like Kconfig was meant to do this, it feel like
somewhat of an abuse ..

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
