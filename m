Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id BDBDA67CB2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Jul 2005 09:33:09 +1000 (EST)
To: T Ziomek <ctz001@email.mot.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 21 Jul 2005 16:12:18 CDT."
	<Pine.WNT.4.61.0507211609080.2672@holyoke.labs.mot.com>
Date: Fri, 22 Jul 2005 01:33:02 +0200
Sender: wd@denx.de
Message-Id: <20050721233302.BDBF5352B83@atlas.denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: AW: AW: AW: initrd rootfs ramdisk 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <Pine.WNT.4.61.0507211609080.2672@holyoke.labs.mot.com> you wrote:
>
> Sigh...found it, after weeks of on-and-off work...  Our board has 64 MB of
> RAM but I'm passing "mem=32M" to the kernel because we want our app to man-
> age the high 32 MB.
> 
> U-Boot defaults to copying an initrd into the highest available RAM.  That
> put it in an area outside of Linux's knowledge, D'OH.  All I had to do was
> set U-Boot's 'initrd_high' env var and things work.

Note: if you want the  content  of  this  reserved  area  to  survice
warmboots  you  can  enable  the  "protected  RAM"  feature in U-Boot
(CONFIG_PRAM), and it will not touch this area  at  all.  Useful  for
things like pramfs for example :-)

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Never worry about theory as long as  the  machinery  does  what  it's
supposed to do.                                      - R. A. Heinlein
