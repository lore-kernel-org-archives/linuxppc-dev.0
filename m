Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 1895667A70
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 06:01:34 +1100 (EST)
Date: Wed, 23 Feb 2005 12:01:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050223190123.GI345@smtp.west.cox.net>
References: <c3d0340b05022310396240c8ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b05022310396240c8ac@mail.gmail.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Ebony's UBoot awareness
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 23, 2005 at 10:39:34AM -0800, Shawn Jin wrote:

> This adds UBoot support on Ebony board and also sets emac's PHY mode
> explicitly during initialization as Eugene Surovegin provided.
[snip]
> +#include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"

This will not work with O= for example.  The correct method is to modify
the Makefile with a CFLAGS_foo.o += -Idrivers/net/ibm_emac

-- 
Tom Rini
http://gate.crashing.org/~trini/
