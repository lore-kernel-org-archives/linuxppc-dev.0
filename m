Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id 4C658679F0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 May 2005 17:55:15 +1000 (EST)
To: "tuotuo wang" <dvdstar@hotmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 30 May 2005 01:07:05 -0000."
	<BAY24-F40F8F31EEE582D1E998CFEAD030@phx.gbl>
Date: Mon, 30 May 2005 09:54:44 +0200
Sender: wd@denx.de
Message-Id: <20050530075449.2F141C1512@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: FW: Re: load u-boot.bin failure with BDI2000 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <BAY24-F40F8F31EEE582D1E998CFEAD030@phx.gbl> you wrote:
> 
> You know,my config file of BDI2000 is download from www.denx.de,because 
> there have the sbc8260's.My board run the ppcboot at first,and i can use my 
> BDI2000 properly with this config file.

Most probably you erased the flash  (including  the  HRCW)  and  then
power-cycled  the  board.  Now your board cannot find a valid HRCW at
poweron which leaves the CPU in a unusable state in  which  not  even
JTAG access is working.

There should be a jumper or  switch  on  your  board  to  enable  the
default  configuration  - search for RSTCONF or so. Note that you may
have  to  adjust  the  config  file  for  the  default  configuration
(BOOTADDR and maybe others, too).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You can observe a lot just by watchin'.                  - Yogi Berra
