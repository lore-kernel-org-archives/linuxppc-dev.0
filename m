Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id C8721DDDD6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Oct 2007 09:15:44 +1000 (EST)
Received: from edison2.selinc.com (edison2.selinc.com [12.110.71.57])
	by tesla.selinc.com (8.12.11.20060308/8.12.11) with ESMTP id
	l93NFgqk003466
	for <linuxppc-embedded@ozlabs.org>; Wed, 3 Oct 2007 16:15:42 -0700
In-Reply-To: <OFFFD4BE8F.17F6E427-ON88257369.006D8651-88257369.00736D96@selinc.com>
To: Bruce_Leonard@selinc.com
Subject: Re: Device tree and external RTC
MIME-Version: 1.0
Message-ID: <OF5A3A8901.AAC62E29-ON88257369.007F3E0B-88257369.007FC5D0@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Wed, 3 Oct 2007 16:15:39 -0700
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org wrote on 10/03/2007 
02:00:49 PM:

> Hi all,
> 
> I'm seriously confused by how things are supposed to work now with 
device 
> trees on the PowerPC arch.  I'm bringing up our custom HW which is 
bassed 

<HUGE snip>

Follow up:

Okay, I figured out that I was indeed reading the clock (should have been 
using date command rather than hwclock command), so sorry for the noise. 
So what is is that hwclock is trying to do that it's unhappy about?

I still think I've got a valid question about the device tree.  Isn't the 
purpose of the device tree to completely describe the HW to the kernel? 
Shouldn't I be able to add a child node to the i2c node describing the 
M41T00 RTC and have the kernel figure out that there's an RTC hanging off 
the I2C bus?  Or am I completely off base here?

Bruce
