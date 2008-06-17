Return-Path: <olof@lixom.net>
Received: from elcamino.pasemi.com (elcamino.pasemi.com [67.155.108.98])
	by ozlabs.org (Postfix) with ESMTP id 00AE4DE16E
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 03:41:16 +1000 (EST)
Message-Id: <EBFD6FC8-4C8D-483A-A819-BB813D388FF9@lixom.net>
From: Olof Johansson <olof@lixom.net>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1213719098-28002-1-git-send-email-ncase@xes-inc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH v2] USB: isp1760: Support board-specific hardware
	configurations
Date: Tue, 17 Jun 2008 12:41:13 -0500
References: <1213719098-28002-1-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org, Sebastian Siewior <sebastian@breakpoint.cc>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 17, 2008, at 11:11 AM, Nate Case wrote:

> This adds support for hardware configurations that don't match the
> chip default register settings (e.g., 16-bit data bus, DACK and
> DREQ pulled up instead of down, analog overcurrent mode).
>
> These settings are passed in via the OF device tree.  The PCI
> interface still assumes the same default values.
>
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> ---
> This version addresses feedback from Sebastian Siewior and
> Olof Johansson.  Specifically, a new flag was added for ISP1761 which
> is set during probe time.  This is used instead of checking the Chip
> ID register (which doesn't allow you to distinguish between the  
> ISP1760
> and ISP1761).  Also, device tree property checking is adjusted to
> simply check for a property's presence when setting flags.
>
> I tested this version on both a custom ppc64 board and Electra.
> Olof also tried testing it on his Electra but without success (I'm
> guessing, perhaps naively, that a difference between our setups was
> the cause and the driver changes are still OK).

Yeah, I'm not 100% sure that it's not broken hardware here. Even if it  
turns out not to be what's wrong, the rest of the patch seems good to  
me. I.e. good enough to merge even if it'll take a fix to iron out the  
last stuff down the road.


Acked-by: Olof Johansson <olof@lixom.net>


-Olof
