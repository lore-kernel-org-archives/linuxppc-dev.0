Return-Path: <lk99336@pobox.sk>
Received: from bobek.mail-atlas.net (bobek.mail-atlas.net [212.47.13.89])
	by ozlabs.org (Postfix) with ESMTP id D2E5567A3D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 01:11:45 +1000 (EST)
Received: from bobek ([127.0.0.1]) by bobek.mail-atlas.net
	for linuxppc-embedded@ozlabs.org; Mon, 22 May 2006 17:10:59 +0200
From: "=?us-ascii?B?TGFkaXNsYXYgS2xlbm92aT8=?=" <lk99336@pobox.sk>
To: linuxppc-embedded@ozlabs.org
Message-ID: <68fe5e37fc274a4daa3197e0590006ca@pobox.sk>
Date: Mon, 22 May 2006 17:10:59 +0200
Subject: Re: Re: SCC1 as serial console
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>-----P?vodn? spr?va-----
>Od: Laurent Pinchart [mailto:laurent=2Epinchart@tbox=2Ebiz]
>Odoslan?: 22=2E m?ja 2006 14:12
>Komu: linuxppc-embedded@ozlabs=2Eorg
>Predmet: Re: SCC1 as serial console
>
>
>Hi Ladislav,
>
>> can anybody help me to setup the SCC1 port as serial console on MPC8=
60 with
>> kernel 2=2E6=2E15=2E4? I would like to use it as system console duri=
ng the
>> booting proccess=2E I can not get any output on serial console durin=
g booting
>> proccess, I use uboot=2E
>
>Does SCC1 work correctly in U-Boot ? If not, you should fix that first=
=2E I'll
>assume it does=2E

Yes, it works fine for kernel 2=2E4=2E22=2E

>There are many issues which could lead to a silent serial console=2E T=
he serial
>port could be misconfigured, or the kernel could crash for another rea=
son
>before the serial port is initialized=2E

I did a little experiment, I turn off the root file system so my kernel=
(system,=2E=2E) restart=20
after 180 seconds=2E When there was something wrong the there wasn't  s=
ystem restart=2E
But, ofcourse I CAN NOT be sure that this selince is due an another err=
or or I just can=20
not see the output=2E

>Have you been able to get a serial console on another serial port (SMC=
) ? Are
>the clock frequencies computed by U-Boot and passed to the Linux kerne=
l
>correct ?

Please can you explain how to get thi serial to SMC?

>
>Do you have a hardware debugger (BDI2000) that you can connect to the
>processor to see if Linux crashes before initializing the serial port =
? If
>not, you will probably have to take a try at led-debugging (make some =
leds
>blink at various point in the Linux kernel to try to find out what hap=
pens),
>but that's really no fun=2E
>
No I don't have any :(

Ladislav Klenovic_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs=2Eorg
>https://ozlabs=2Eorg/mailman/listinfo/linuxppc-embedded
