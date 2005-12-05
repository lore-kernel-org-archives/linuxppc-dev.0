Return-Path: <yorksun@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id E965868802
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Dec 2005 06:39:11 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	jB5Jnb3f024922
	for <linuxppc-embedded@ozlabs.org>; Mon, 5 Dec 2005 12:49:37 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id jB5Jk2gB027265
	for <linuxppc-embedded@ozlabs.org>; Mon, 5 Dec 2005 13:46:03 -0600 (CST)
From: York Sun <yorksun@freescale.com>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20051205132239.4a67e575.kim.phillips@freescale.com>
References: <20051205132239.4a67e575.kim.phillips@freescale.com>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 13:37:22 -0600
Message-Id: <1133811442.3357.24.camel@york.somerset.freescale.net.somerset.sps.mot.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Fw: Anyone using CodeWarrior USB TAP?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Addison,

I don't know if you can receive this reply since I am not in the mailing
list.

The answer is that the USB TAP can work under Linux. You will need
CodeWarrior Linux version. The current version is 2.6. Please contact
the sales of channels where you got your board.

No specific driver is required for Linux. Just kindly remind you to
check the writing privilege of /proc/bus/usb/001/* if you not the root
user.

York


On Mon, 2005-12-05 at 13:22 -0600, Kim Phillips wrote:
> York, know anything about this?  If you're subscribed, could you answer directly to the list?
> 
> Kim
> 
> Begin forwarded message:
> 
> Date: Mon, 5 Dec 2005 17:05:39 +0000
> From: Addison Baldwin <addison.baldwin@gmail.com>
> To: linuxppc-embedded@ozlabs.org
> Subject: Anyone using CodeWarrior USB TAP?
> 
> 
> Hi
> 
> I received a MPC8272ADS board from Freescale, and I'm trying to use a
> CodeWarrior USB TAB that has been provided with the board. It seems that
> such a device only works under Windows, as I didn't find a driver to make it
> works under Linux.
> 
> I would like to know if anyone have got the CodeWarrior USB working under
> Linux.
> 
> Thanks,
> Addison
> 
> 
> 
-- 
York Sun
 
This email, and any associated attachments have been classified as:
[x] Freescale Semiconductor General Business
[ ] Freescale Semiconductor Internal Use Only
[ ] Freescale Semiconductor Confidential Proprietary
