Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 99F526884E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 02:29:48 +1100 (EST)
To: Hans Schillstrom <hans.schillstrom@pwav.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Dec 2005 13:26:21 +0100."
	<1133439981.8518.237.camel@hawk.pwav.net>
Date: Thu, 01 Dec 2005 16:29:46 +0100
Sender: wd@denx.de
Message-Id: <20051201152946.E6E53353B0C@atlas.denx.de>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8555 8280/8270 USB host support 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1133439981.8518.237.camel@hawk.pwav.net> you wrote:
> 
> Don't you think u-boot should take care of clock setup
> i.e. as much as possible of all board dependent stuff ?

No, it should not. A river should not make any assumptions about  the
state of the hardware, but initialize everything it needs for correct
operation itself.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Save yourself!  Reboot in 5 seconds!
