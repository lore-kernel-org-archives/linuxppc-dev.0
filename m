Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id 6A11567EBD
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 22:39:59 +1000 (EST)
To: =?big5?B?rn2z06vC?= <rober.hsu@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 04 Aug 2005 20:20:49 +0800."
	<001401c598ee$f59b20f0$0e01000a@orange>
Date: Thu, 04 Aug 2005 14:39:49 +0200
Sender: wd@denx.de
Message-Id: <20050804123949.3388F352B36@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: about linux 2.4.25 on MPC852T 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <001401c598ee$f59b20f0$0e01000a@orange> you wrote:
> 
>      I'm porting Linux 2.4.25 at my MPC852T.I can make uImag and
> ramdisk.tar.gz  now.
> My question is how to combine these two file to linux.bin  let linux
> auto mount ramdisk.image.gz.

Specify image type "multi" when running the U-Boot "mkimge" tool.

> I think one file would be easy to maintain and download.

This depends on the requirements. It may be very useful to be able to
change the application image while keeping the known  to  be  working
kernel constant.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Einstein argued that there must be simplified explanations of nature,
because God is not capricious or arbitrary. No  such  faith  comforts
the software engineer.                             - Fred Brooks, Jr.
