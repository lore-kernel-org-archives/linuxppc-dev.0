Return-Path: <greg@kroah.com>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6E254B6F68
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 23:03:21 +1100 (EST)
Date: Tue, 11 Oct 2011 06:00:19 -0600
From: Greg KH <greg@kroah.com>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: [PATCH] Fix interrupt handling in MPC8xxx GPIO driver
Message-ID: <20111011120019.GB9093@kroah.com>
References: <1318321461-3066-1-git-send-email-felix@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318321461-3066-1-git-send-email-felix@embedded-sol.com>
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 11, 2011 at 10:24:21AM +0200, Felix Radensky wrote:
> Interrupt handler in MPC8xxx GPIO driver is missing the call
> to PIC EOI (end of interrupt) handler. As a result, at least
> on 85XX systems, GPIO interrupt is delivered only once. This
> patch adds the missing EOI call. Tested on custom P1022 board.
> 
> Signed-off-by: Felix Radensky <felix@embedded-sol.com>
> ---
>  arch/powerpc/sysdev/mpc8xxx_gpio.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
