Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7E449DDEA3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Mar 2007 07:27:49 +1000 (EST)
To: Thomas Maenner <tmaenner@aehr.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Avoid using libm in rootfs 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 29 Mar 2007 13:45:35 PDT."
	<200703291345.35978.tmaenner@aehr.com>
Date: Thu, 29 Mar 2007 23:27:46 +0200
Sender: wd@denx.de
Message-Id: <20070329212746.E8F36353A6C@atlas.denx.de>
Cc: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200703291345.35978.tmaenner@aehr.com> you wrote:
> 
> Maybe on the same subject or OT, I'm having trouble with ELDK 4.1.0, kernel
> 2.4.25, u-boot 1.1.6, kernel and ramdisk copied from flash into RAM on a 
> TQM860L module.

Using ELDK 4.1 (= a toolchain build for a  2.6  kernel)  with  a  2.4
kernel  is  not  a supported mode of operation. Please use ELDK 3.1.1
for runtime environment of your 2.4 kernel.

> Shouldn't the paths from ldd be for example /lib/libc.so.6 ?

No, the cross-version of ldd shows the full path name in the cross
environment.

> Anybody has any idea what that could be?

Incompatibility of libraries. Use ELDK 3.x with 2.4 kernels, and ELDK
4.x with 2.6 kernels; anything else is asking for trouble.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
God is real, unless declared integer.
