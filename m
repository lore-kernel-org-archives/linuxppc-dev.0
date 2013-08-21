Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 382CC2C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 09:33:59 +1000 (EST)
Message-ID: <1377128031.5029.75.camel@snotra.buserror.net>
Subject: Re: [PATCH v7 1/3] DMA: Freescale: revise device tree binding document
From: Scott Wood <scottwood@freescale.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 21 Aug 2013 18:33:51 -0500
In-Reply-To: <52154976.2010204@wwwdotorg.org>
References: <1375094944-3343-1-git-send-email-hongbo.zhang@freescale.com>
 <1375094944-3343-2-git-send-email-hongbo.zhang@freescale.com>
 <5215402E.70007@wwwdotorg.org>
 <1377125156.5029.40.camel@snotra.buserror.net>
 <52154976.2010204@wwwdotorg.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, hongbo.zhang@freescale.com,
 linux-kernel@vger.kernel.org, vinod.koul@intel.com, djbw@fb.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-08-21 at 17:12 -0600, Stephen Warren wrote:
> OK, if there's some alternative run-time way of enabling chip-specific
> quirking, it's probably fine to remove the extra compatible values.
> 
> Now, that does rather assume that this DMA IP block will only ever be
> used within SoCs that have that SVR concept, but perhaps if that's ever
> not the case, we can simply go back to requiring extra compatible values
> in those specific cases?

The only situation I can see where SVR would be absent is if we were to
integrate this device into an ARM chip, in which case I'd expect there
to be some equivalent way to find the SoC identification.  If the driver
knows what SoC version it expects, it will know the way that that SoC
advertises its version.

-Scott
