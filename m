Return-Path: <chuck@ThePTRGroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.178.251.9])
	by ozlabs.org (Postfix) with ESMTP id 3145FB6F11
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 08:22:48 +1000 (EST)
Message-ID: <4C3CE5BA.5060302@ThePTRGroup.com>
Date: Tue, 13 Jul 2010 18:16:26 -0400
From: Chuck Meade <chuck@ThePTRGroup.com>
MIME-Version: 1.0
To: Fushen Chen <fchen@apm.com>
Subject: Re: [PATCH 1/9 v1.01] Add Synopsys DesignWare HS USB OTG Controller
	driver.
References: <12789766042434-git-send-email-fchen@apm.com>
In-Reply-To: <12789766042434-git-send-email-fchen@apm.com>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, chuck@theptrgroup.com, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, gregkh@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/12/2010 07:16 PM, Fushen Chen wrote:
> The DWC OTG driver module provides the initialization and cleanup
> entry points for the DWC OTG USB driver.
> 
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
> ---

This reply is to the patch series, not just this 1/9 patch section.

Fushen, why did you pick and choose which fixes to incorporate from the Denx
tree's version of the dwc_otg driver?

I'm not taking the time here to go through this multipart patch and check that
you incorporated every fix, but I *did* randomly pick one fix that I made to that
driver, to see if you incorporated it, and it appears you did not.
I would have expected that you would have incorporated the fixes that were made
to this driver in the Denx tree.

The one that I checked is in the data toggle error interrupt handling, in
handle_hc_chhltd_intr_dma() (see your 5/9 email in this patch series).  It looks
like you left out the fix I made to this logic that averts an interrupt storm.

I assume that since I checked one particular fix, and it was missing from your
patch series, that there are likely more fixes you omitted.  Can you explain why
you would leave this out, after Stefan asked you to incorporate the code changes
made in the Denx tree's version of the driver?

Chuck
