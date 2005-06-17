Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id 5DFED67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Jun 2005 05:12:46 +1000 (EST)
To: j.lu@tiesse.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 17 Jun 2005 16:15:29 +0200."
	<000001c57347$04a45d00$07070a0a@luj>
Date: Fri, 17 Jun 2005 21:12:26 +0200
Sender: wd@denx.de
Message-Id: <20050617191231.B23C0C1510@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: problems on isp1362 driver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Jianliang Lu,

in message <000001c57347$04a45d00$07070a0a@luj> you wrote:
> 
> We are using Philips ISP1362 usb controller on our ppc-embedded system. We
> have ported the phlips's driver, PHCI, to ppc. The Philips linux driver is
> that of  2002.

You cannot do that. The  Philips  driver  comes  uner  a  proprietary
license  which  is  incompatible with the GPL. You must not use their
driver in the context of a Linux kernel or any other GPLed  software.
You  are  either  violating  the  GPL,  or  the  Philips  license. Be
careful!!!

> >From the list I've seen that Wolfgang Denk  has worked for that driver and

No!!! We never had any access to the Philips drivers. We are proud of
using Free Software exclusively and will not accepts such a license.

> test is for a lot of devices. I'd like to know from Wolfgang which driver is
> used? Is the driver that you are using is open source? Where can we get it?

Our version of the driver is Free Software under GPL. It is included
in the linuxppc_2_4_devel module on our CVS server, see
http://www.denx.de/re/linux.html


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
       There is enough for the need of everyone in this world,
       but not for the greed of everyone.     - Mahatma Gandhi
