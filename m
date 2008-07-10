Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 19DF9DDE20
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 00:58:45 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so1946724wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 07:58:44 -0700 (PDT)
Date: Thu, 10 Jul 2008 08:58:07 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: [PATCH] MPC52xx PCI write combine timer
Message-ID: <20080710145807.GB446@secretlab.ca>
References: <4875DC0C.2060609@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4875DC0C.2060609@matrix-vision.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 10, 2008 at 11:53:16AM +0200, Andre Schwarz wrote:
> On MPC52xx the PCI target control register (PCITCR) @ MBAR + 0xD6C is initialized with
> only bit 7 (Latrule disable) set. The 8-Bit write combine timer (Bits 24..31) should be
> also set to a reasonable value _greater zero_ (0x08 = default) since setting it to 0x00
> leads to _very poor_ performance as a PCI target since external burst won't be possible
> at all.
> 
> Setting the WCT to 0x08 (cache-line size) leads to good overall perfomance.

Looks good to me.  I'll test it here and pick it up if all looks good.

Cheers,
g.
