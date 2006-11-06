Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6232B67D06
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 21:31:40 +1100 (EST)
To: "Goel, Mudit (Mudit)" <muditg@lucent.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Linux Kernel 2.6 on Artesyn Katana Board (3750) with IBM 750FX PP
	C
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 06 Nov 2006 15:41:15 +0530."
	<3BE48DD0EC7D3948BC183931D9150C210BBB0BAB@ii0015exch001u.iprc.lucent.com>
Date: Mon, 06 Nov 2006 11:31:37 +0100
Sender: wd@denx.de
Message-Id: <20061106103137.9AFFA353A60@atlas.denx.de>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <3BE48DD0EC7D3948BC183931D9150C210BBB0BAB@ii0015exch001u.iprc.lucent.com> you wrote:
>   We are trying to upgrade the kernel to 2.6. The kernel upgrade is success
> on one card with ppc boot version 1.2 
>   with release date of July 2004. 
>   
>   But all other cards which have different dates but same boot version the
> kernel upgrade is not successful.
>   Here is the boot output
>  ---------------------------- 
> P1(2.01)=>go 0x08010000
> ## Starting application at 0x08010000 ...
> loaded at:     08010000 081EA320
> relocated to:  00800000 009DA320
> zimage at:     00805909 009D78BD
> avail ram:     00700000 00B00000
> max kernel:    00600000

This is NOT the correct way to boot Linux using  U-Boot.  You  should
create  a  U-Boot  image  file (using the mkimage tool, resp. running
"make  uImage"),  and  boot  this  using  the  "bootm"   command   as
documented in the README and the manual.

Please read the documentation.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I'm what passes for a Unix guru in my office. This is  a  frightening
concept. - Lee Ann Goldstein, in <3k55ba$c43@butch.lmsc.lockheed.com>
