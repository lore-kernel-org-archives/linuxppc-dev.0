Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 4E1CDDDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Aug 2007 21:41:34 +1000 (EST)
Message-ID: <46B3146C.4020100@anagramm.de>
Date: Fri, 03 Aug 2007 13:41:32 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: mahendra varman <mahendravarman15@gmail.com>
Subject: Re: reg : SM722 Linux driver
References: <4ac2955e0708030421r3b6d6b0at179e86fb6ff461a6@mail.gmail.com>
In-Reply-To: <4ac2955e0708030421r3b6d6b0at179e86fb6ff461a6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

mahendra varman schrieb:
> Hi Members
> 
> Iam in need of SM722 Linux driver source code for Linux 2.6 or for Linux 2.4
> 
> Help me to find the source code

You will find Xfree86 drivers from Siliconmotion here:
http://www.siliconmotion.com.tw/en/en2/download2c.htm

And the siliconmotion driver of Xorg in it's git repository:
http://gitweb.freedesktop.org/?p=xorg/driver/xf86-video-siliconmotion.git;a=summary

I don't think there are in-kernel framebuffer drivers (tried the vesa ones?)
for the SM722 (==Lynx3DM+), read the code. ;-)

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
