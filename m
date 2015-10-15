Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 390901A06AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 22:10:57 +1100 (AEDT)
In-Reply-To: <1443728500-29078-1-git-send-email-aaro.koskinen@iki.fi>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: drivers/macintosh: adb: fix misleading Kconfig help text
Message-Id: <20151015111056.BA6821402D5@ozlabs.org>
Date: Thu, 15 Oct 2015 22:10:56 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-10 at 19:41:40 UTC, Aaro Koskinen wrote:
> CONFIG_INPUT_KEYBDEV does not exist and no additional keyboard-specific
> options are needed to get the keyboard working.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f27b86dc1ec41ff4b5b58094

cheers
