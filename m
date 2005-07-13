Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 9D78767BFB
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jul 2005 02:04:07 +1000 (EST)
Date: Wed, 13 Jul 2005 09:04:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Message-ID: <20050713160405.GK7741@smtp.west.cox.net>
References: <20050713135525.GA18144@suse.de> <20050713135626.GB18144@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050713135626.GB18144@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] update ppc defconfigs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2005 at 03:56:26PM +0200, Olaf Hering wrote:

> update pmac_defconfig
> 
> enable all relevant options in common_defconfig,
> so it can serve as a compiletest for PPC_MULTIPLATFORM configuration
> 
> Signed-off-by: Olaf Hering <olh@suse.de>

[snip]
> -CONFIG_LOCALVERSION=""
> +CONFIG_LOCALVERSION="common_defconfig"

Please don't do that.  $WHOMEVERs mass-compile-scripts should be setting
this to $WHATEVER.

> -CONFIG_MODULE_FORCE_UNLOAD=y
> +# CONFIG_MODULE_FORCE_UNLOAD is not set

Why?  It looks like you're doing more than running oldconfig here..

-- 
Tom Rini
http://gate.crashing.org/~trini/
