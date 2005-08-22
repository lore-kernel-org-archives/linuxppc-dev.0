Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 4028867FEA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Aug 2005 23:07:19 +1000 (EST)
To: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 22 Jul 2005 18:37:47 +0800."
	<20050822104924.214ED429CB@denx.de>
Date: Mon, 22 Aug 2005 15:07:02 +0200
Sender: wd@denx.de
Message-Id: <20050822130702.27D5F353D18@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel MTD question 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050822104924.214ED429CB@denx.de> you wrote:
> 
> How can I put the Environment variables or configurations in
> 0x00060000-0x00080000, or put User Data in 0x005C0000-0x1000000?
> Use U-boot command? Or....

It is up to you to define a memory map for your flash  device(s)  and
create  appropriate partitions for this map in Linux (and probably in
U-Boot, too, using the new "mtdparts" command).

Then you can use standard commands in U-Boot (erase, cp) and in Linux
(erase_all, cp) to store any data you likein your flash.

It is *your* design. *You* must create it.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The IQ of the group is the lowest IQ of a member of the group divided
by the number of people in the group.
