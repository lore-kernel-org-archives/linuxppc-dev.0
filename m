Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 51D95688F3
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 02:48:14 +1100 (EST)
To: Matthias Transier <matthias.transier@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 04 Jan 2006 12:33:58 +0100."
	<b789c2e60601040333o42d64c52n@mail.gmail.com>
Date: Wed, 04 Jan 2006 16:48:12 +0100
Sender: wd@denx.de
Message-Id: <20060104154812.24858352B1E@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Segmentation fault with X.org and Coral-P drivers 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Matthias,

in message <b789c2e60601040333o42d64c52n@mail.gmail.com> you wrote:
> 
> I have been trying to get X.org running on a board called "Embedded
> Planet EP5200C" (it seems to be a "Freescale Lite5200") and a Fujitsu

Umm... no. Embedded Plaet and Freescale are two different  companies,
and EP5200 and Lite5200 are two different boards.

> Coral-P (Rev 5.0). I am using the 2.4 kernel from denx.de and

Our kernel does not include any support for the EP5200 board.

> succesfully installed gentoo-ppc on nfs. The framebuffer works, I get
> a login prompt on the monitor.
> 
> Now I compiled x.org-6.8.2 (gentoo -r4) and the mb86290 driver from
> denx.de. Unfortunately, it does not work and I get a segmentation
> fault when trying to startx. strace produces the output attached
> below.

Please read the documentation that comes with the driver:
ftp://ftp.denx.de/pub/fujitsu/Coral-P/README.html

Note that the driver was  built  and  tested  against  xfree86-4.3.0;
don't  expect  the  binary  to  work  in  a  completely different X11
release. You wil have to rebuild (and eventually  adapt)  the  driver
for your environment.

Feel free to contact me if you need help.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
What can it profit a man to gain the whole world and to come  to  his
property with a gastric ulcer, a blown prostate, and bifocals?
                                     -- John Steinbeck, _Cannery Row_
