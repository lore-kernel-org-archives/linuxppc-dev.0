Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D4ED1DE079
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Mar 2007 08:26:17 +1100 (EST)
To: Thomas Maenner <tmaenner@aehr.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: TQM 860L, 64MB RAM, ELDK4.1, TQM860L, Kernel 2.6.19 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 22 Mar 2007 14:10:37 MST."
	<200703221410.37767.tmaenner@aehr.com>
Date: Thu, 22 Mar 2007 22:26:15 +0100
Sender: wd@denx.de
Message-Id: <20070322212615.553FE35260B@atlas.denx.de>
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

In message <200703221410.37767.tmaenner@aehr.com> you wrote:
> Tried out the following u-boot "setting":
> setenv ramargs setenv bootargs ramdisk_size=6144 root=/dev/ram console=ttyCPM0 rw
> 
> No change; still no output in the console

Then buy a debugger and dig into it...

> Note that my module has 64MB, rather that 16; I thought it doesn't matter, or?

It doesn't.

You are aware that TQM8xxL is not yet supported in the context of the
2.6 Linux kernel, aren't you? [And we will  not  support  it  in  the
ARCH=ppc context any more.]

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
We are all agreed that your  theory  is  crazy.  The  question  which
divides  us  is  whether it is crazy enough to have a chance of being
correct. My own feeling is that it is not crazy enough.  - Niels Bohr
