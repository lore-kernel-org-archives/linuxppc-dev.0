Return-Path: <eddie@embeddedarm.com>
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id D6E23DDECA
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 04:32:27 +1000 (EST)
Message-ID: <49DCEE6B.7010704@embeddedarm.com>
Date: Wed, 08 Apr 2009 11:35:23 -0700
From: Eddie Dawydiuk <eddie@embeddedarm.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: AMCC 440EP phy detection
References: <49DB8033.1090908@embeddedarm.com> <200904081801.27754.sr@denx.de>
	<fa686aa40904081000x2dbdd417y149fe442b9fc55bf@mail.gmail.com>
	<200904082019.06889.sr@denx.de>
In-Reply-To: <200904082019.06889.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan,

> Ack. We usually do all this setup in U-Boot. But as I understand Eddie, he is 
> using a custom bootloader.

Correct, I'll put this code in the platform initialization. Thanks for the 
suggestions everyone.

> Eddie, btw: Why are you not using U-Boot?

At Technologic Systems, one of our design goals for all of our products is to 
achieve a very quick boot time(under 2 seconds to a shell prompt). We then 
provide a user space utility to boot another linux kernel, this allows our 
customers to use Linux as a bootloader. We boot to an initial ramdisk then use a 
linuxrc script as a replacement for a typical bootloader(e.g. U-Boot). In the 
background we can then mount a large filesystem with Debian installed. In my 
opinion it works out quite nicely in that one can use our boards as more of an 
appliance(apply power and it's on, rather than waiting for a computer to boot).

-- 
Best Regards,
________________________________________________________________
  Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
  16525 East Laser Drive 	     | fax:    (480) 837-5300
  Fountain Hills, AZ 85268            | web: www.embeddedARM.com
