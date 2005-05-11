Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id E0C34679F7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 May 2005 23:28:33 +1000 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 May 2005 12:40:35 +0200."
	<200505111240.35425.david.jander@protonic.nl>
Date: Wed, 11 May 2005 15:28:05 +0200
Sender: wd@denx.de
Message-Id: <20050511132810.E7228C1512@atlas.denx.de>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Status of isp116x driver... (on mpc8xx)? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear David,

in message <200505111240.35425.david.jander@protonic.nl> you wrote:
> 
> I connected a Philips ISP1160 usb host controller to a MPC852T-based custom 
> board. I am using CVS kernel from DENX. 
> I added some stuff to hcd-1161.h and hcd-1161.c to support our hardware, and 
> it seems to work at first.
...
> Is the isp1160 chip really supported by the driver? tested?

We only use (and tested) this driver with a ISP1361 ...

> Is someone using a isp116x on a mpc8xx and can tell his experience on getting 
> it working?

Sorry, we don't have any experience with a 1160. The  driver  in  our
tree  works fine with the 1362, both as host driver and as device (as
a gadget driver).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
No man knows what true happiness is until he gets married.  By  then,
of course, its too late.
