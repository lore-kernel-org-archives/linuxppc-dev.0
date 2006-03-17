Return-Path: <Bjorn.Ostby@combitech.se>
Received: from ms-101.aerotechtelub.se (ms-101.aerotechtelub.se
	[192.176.33.163]) by ozlabs.org (Postfix) with ESMTP id 92840679E2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Mar 2006 17:55:08 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: 8xx SMC1 problem 
Date: Fri, 17 Mar 2006 07:55:06 +0100
Message-ID: <004B1D7A5257174C9044A1B7BD0E60ED0178CC6A@ratatosk.combitechsystems.com>
From: =?iso-8859-1?B?Qmr2cm4g1nN0Ynk=?= <Bjorn.Ostby@combitech.se>
To: <wd@denx.de>
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

>From: wd@denx.de [mailto:wd@denx.de]
>Sent: den 16 mars 2006 21:10
>To: Bj=F6rn =D6stby
>Cc: linuxppc-embedded@ozlabs.org
>Subject: Re: 8xx SMC1 problem
>
>In message <004Bxxxxx@ratatosk.combitechsystems.com> you wrote
>>
>> First of, I have three serial ports (SMC1, SMC2 and SCC3) and they =
all
>> work  fine when the console is on SMC1. I have gadgets connected to
>> SMC2 and SCC 3 and now I need SMC1 for yet another device. So I have
>> undefined CONFIG_SE RIAL_CONSOLE in the kernel config and I jump out=20
>> of u-boot (which have the console on SMC1) with the argument
>> "console=3Dnone".
>
>And did you make sure that no other process is accessing ttyS0 ?
>
>> When logging in (via telnet) ttyS0 works no more (but S1 and S2 =
does).
>> At r andom bootups, it is possible to open the port but it is no good
>> for read o r write.
>>
>> Can anybody give me some advise on how to enable SMC1 but at the same
>> time don't have a console on it?
>
>We did the same (passing console=3Dnull) in a couple of  configurations =
and
>had  no  problems  >using SMC1 as standard serial port. Try *not* =
undefining
>CONFIG_SERIAL_CONSOLE.
>

Ahh, "console=3Dnull" worked a lot better than "console=3Dnone".=20
Problem solved!

>
>And please keep your line length < 72 characters or so.
>

I'll see to that.


Regards,
Bj=F6rn =F6stby
