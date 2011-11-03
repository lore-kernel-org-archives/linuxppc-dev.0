Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5EAC2B6F18
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 05:16:35 +1100 (EST)
Subject: Re: [PATCH] Fix interrupt handling in MPC8xxx GPIO driver
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1318321461-3066-1-git-send-email-felix@embedded-sol.com>
Date: Thu, 3 Nov 2011 12:59:59 -0500
Message-Id: <52047596-F058-4803-9B2D-897B25A556E0@kernel.crashing.org>
References: <1318321461-3066-1-git-send-email-felix@embedded-sol.com>
To: Felix Radensky <felix@embedded-sol.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 11, 2011, at 3:24 AM, Felix Radensky wrote:

> Interrupt handler in MPC8xxx GPIO driver is missing the call
> to PIC EOI (end of interrupt) handler. As a result, at least
> on 85XX systems, GPIO interrupt is delivered only once. This
> patch adds the missing EOI call. Tested on custom P1022 board.
> 
> Signed-off-by: Felix Radensky <felix@embedded-sol.com>
> ---
> arch/powerpc/sysdev/mpc8xxx_gpio.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied. fixed to apply to new location of gpio driver

- k
