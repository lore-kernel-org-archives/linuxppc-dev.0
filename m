Return-Path: <oxymoron@waste.org>
Received: from waste.org (waste.org [216.27.176.166])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "waste.org", Issuer "waste.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DCE31686C1
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2005 09:52:21 +1100 (EST)
Date: Tue, 8 Nov 2005 14:39:27 -0800
From: Matt Mackall <mpm@selenic.com>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20051108223927.GE9760@waste.org>
References: <20051108223631.GR3839@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051108223631.GR3839@smtp.west.cox.net>
Cc: Andrew Morton <akpm@osdl.org>, Kumar Gala <galak@gate.crashing.org>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.14] ppc32: Fix CONFIG_PRINTK=n building
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 08, 2005 at 03:36:31PM -0700, Tom Rini wrote:
> The following patch is needed to allow PRINTK=n to work on ppc32.
> 
> Direct calls to printk from asm files can't be magically removed so we
> have to do it manually.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Looks good. 

Acked-by: Matt Mackall <mpm@selenic.com>

-- 
Mathematics is the supreme nostalgia of our time.
