Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id DACBCB7D1D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Apr 2010 17:59:50 +1000 (EST)
Date: Fri, 23 Apr 2010 09:59:30 +0200
From: Anatolij Gustschin <agust@denx.de>
To: "Steve Deiters" <SteveDeiters@BASLER.com>
Subject: Re: [PATCH] Fixes for MPC512x PSC
Message-ID: <20100423095930.3a26b8bd@wker>
In-Reply-To: <181804936ABC2349BE503168465576460E8723C5@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460E8723C5@exchserver.basler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 22 Apr 2010 19:13:21 -0500
"Steve Deiters" <SteveDeiters@BASLER.com> wrote:

> This will apply on the mpc512x-v2.6.33-devel branch of the DENX git
> repository.  This is all mostly based
> on what was in the Freescale LTIB release from the Freescale website.

Please don't use mpc512x-v2.6.33-devel branch, it is obsolete.
Fixes to serial PSC driver have been merged into mainline kernel,
so with v2.6.34-rc5 you do not need all this stuff your patch
addresses.

> On a somewhat unrelated note, does anyone know if the Freescale LTIB
> drivers have been merged into any newer
> kernel versions?  In particular, I could not find a branch that has
> drivers for the newer NAND Flash controller
> that was in the LTIB version.

Pull from mtd-2.6 tree [1] to get newer mpc512x NAND driver.

[1] http://git.infradead.org/mtd-2.6.git

Anatolij
