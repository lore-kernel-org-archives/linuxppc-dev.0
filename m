Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 74BA3688E8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 23:39:36 +1100 (EST)
To: "HappyPhot" <happyphot@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Dec 2005 15:15:03 +0800."
	<000501c6046b$f1abd5a0$0760120a@photon>
Date: Mon, 19 Dec 2005 13:39:33 +0100
Sender: wd@denx.de
Message-Id: <20051219123933.A9F44353A67@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Ramdisk images for test 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <000501c6046b$f1abd5a0$0760120a@photon> you wrote:
>
>   I followed setion 7.6 of DULG and found got two Ramdisk images
> for test for ppc_82xx. One is pRamdisk, another is ramdisk_image.gz.
>   Who can tell what the difference is between them ?

The former is a U-Boot/PPCBoot image, the later one a raw  compressed
ramdisk image. They contain the same data, just packaged differently.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I'm a programmer: I don't buy software, I write it.
                                                  -- Tom Christiansen
