Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 774132BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 04:28:08 +1100 (EST)
Received: from [212.227.126.208] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CpVF0-0006VC-00
	for linuxppc-embedded@ozlabs.org; Fri, 14 Jan 2005 18:28:06 +0100
Received: from [217.80.228.140] (helo=[192.168.1.10])
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CpVF0-0001Hu-00
	for linuxppc-embedded@ozlabs.org; Fri, 14 Jan 2005 18:28:06 +0100
Message-ID: <41E801B4.1010909@anagramm.de>
Date: Fri, 14 Jan 2005 18:30:28 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <20050114161609.37891.qmail@web53805.mail.yahoo.com>
In-Reply-To: <20050114161609.37891.qmail@web53805.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: ELDK on a PowerPC host machine?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Annamaya

I am using a PPC Linux host here, too.

> Thanks for the reply Wolfgang. Can you give me a hint
> on the kind of work that is required to make this work
> for the PPC host?

Maybe you can save a lot of work using a mainstream Linux
distribution for PPC and install the gcc/gdb development as
you need it?!
If you need the ELDK root tree for booting from nfs
just copy the ppc_zyxx- folder over from the ELDK.

Just today, I needed to move to ppc without the ELDK as we
ran out of fast ix86 machines for compiling. I had to go
'back' to my PowerMac G4 which was my 'functional prototype'
for Linux driver development.
Right now (today) I didn't miss anything from the ELDK.

I use the 'CRUX PPC' distribution on that ppc-machine which
is really nice to use (no bells, no whistles).
If you want a fully fledged KDE/Gnome X, maybe you check out
the 'CRUX PPC Evolution' port.
The most painful part was to have the Mac Bootloader installed
to keep have 1x Linux, 2x MacOSX and 1x MacOS9 bootable on
that machine. :-) Maybe I should use U-Boot next time ;-)

Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19



> --- Wolfgang Denk <wd@denx.de> wrote:
> 
> 
>>In message
>><20050114155131.22836.qmail@web53809.mail.yahoo.com>
>>you wrote:
>>
>>>I noticed that ELDK from denx does not support
>>
>>running
>>
>>>on a PowerPC host machine like the Power G4 or G5.
>>>When I tried rebuilding it on a Power G4 with
>>>YellowDog installed on it, it complained that the
>>>PowerPC host machine is not supported. Why is this
>>
>>Correct. PPC host are not supported yet. Also please
>> not  that  only
>>RedHat-7.3 will work as a build host without
>>additional tweaking.
>>
>>
>>>host architecture not supported? I also found out
>>
>>that
>>
>>Little demand? We have seen less than 5 requests for
>>this so far.
>>
>>
>>>MontaVista does not support the PowerPC host
>>>architecture anymore which they did a while ago.
>>
>>What
>>
>>>seems to be the real reason for not supporting
>>
>>this?
>>
>>Probably the same reason: little demand.
>>
>>
>>Well: the ELDK is free software -  if  you  fix  the
>> existing  build
>>problems  and  send  me  a  patch I promise to check
>>it in on the CVS
>>server (as long as it doesn't break anything). But
>>don't expect  this
>>to be an easy job.
>>
>>Best regards,
>>
>>Wolfgang Denk
>>
>>-- 
>>Software Engineering:  Embedded and Realtime
>>Systems,  Embedded Linux
>>Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80
>>Email: wd@denx.de
>>If only God would give me some clear sign! Like
>>making a large  depo-
>>sit in my name at a Swiss Bank.                     
>>   - Woody Allen
>>
> 
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
