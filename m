Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 99E1867C52
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Jun 2006 07:42:42 +1000 (EST)
To: Chris Dumoulin <cdumoulin@ics-ltd.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: help with inittab 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 08 Jun 2006 16:41:54 EDT."
	<44888B92.40409@ics-ltd.com>
Date: Thu, 08 Jun 2006 23:42:39 +0200
Sender: wd@denx.de
Message-Id: <20060608214239.A71EE35265D@atlas.denx.de>
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

In message <44888B92.40409@ics-ltd.com> you wrote:
> I am using the linux kernel 2.6.15 and initrd ramdisk image from ELDK 
> 4.0. Currently, I seem to be able to boot without errors, but after the 
> root filesystem is mounted, things just stop.

And  what's  your  console  device?  Are  you  passing  any  console=
arguments  on  the  command  line?  Is the corresponding device entry
present in the /dev/directory?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Sometimes a feeling is all we humans have to go on.
	-- Kirk, "A Taste of Armageddon", stardate 3193.9
