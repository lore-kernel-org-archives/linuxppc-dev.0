Return-Path: <jacmet@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by ozlabs.org (Postfix) with ESMTP id A97E4DDF46
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 04:01:34 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so3190288fkz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 09:01:31 -0800 (PST)
To: Greg KH <greg@kroah.com>
Subject: Re: [patch v8 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
References: <20080220090727.904160000@sunsite.dk>
	<20080220161435.GD2658@kroah.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 20 Feb 2008 18:01:19 +0100
In-Reply-To: <20080220161435.GD2658@kroah.com> (Greg KH's message of "Wed\,
	20 Feb 2008 08\:14\:35 -0800")
Message-ID: <87mypvd0kg.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	stern@rowland.harvard.edu, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

 Greg> On Wed, Feb 20, 2008 at 10:07:27AM +0100, Peter Korsgaard wrote:
 >> The Cypress c67x00 (EZ-Host/EZ-OTG) controllers are multi-role low/fullspeed
 >> USB controllers. This patch series implements a HCD driver and shows the
 >> work-in-progress status of a gadget driver.
 >> 
 >> I believe patch 1..3 are ready, and I would like to see them queued up for
 >> mainline.
 >> 
 >> Changes since v7:
 >> - Moved dummy hcd probe/remove functions for conditional hcd support into
 >> udc patch.
 >> - Moved usb_disabled() check into c67x00_hcd_probe().
 >> - Moved c67x00_get_comm_reg() to udc patch as it is only needed for gadget
 >> support.

 Greg> So this fixes the build errors/warnings I sent you?

Well, I cannot reproduce the errors you showed (with Linus -git), but
it does fix a warning about c67x00_get_comm_reg being unused.

 Greg> Can you run them through scripts/checkpatch.pl to ensure that those
 Greg> warnings are also fixed?

Yes, I'll send a new series shortly.

-- 
Bye, Peter Korsgaard
