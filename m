Message-ID: <011801c412b5$46cc6f40$150a0a0a@netoriented.com>
Reply-To: "Tang Nguyen" <tang@netoriented.com>
From: "Tang Nguyen" <tang@netoriented.com>
To: "li" <slowforce@21cn.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <A2959674806480.19317@webmail2.inner-21cn.com>
Subject: Re: APC overflow
Date: Thu, 25 Mar 2004 14:05:25 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Li,

Thank you very much for your suggestion.
Yes,  my system can receive correctly - but the transmitter does not work
even I have masked APCO interrupt.
The line rate is 2.3Mbs, so the PCR should be 2.3Mbs/(53*8) ->5424 cells.  I
have tried to increase the PCR but no luck.
Do I need to check anything else ?

-t


----- Original Message -----
From: "li" <slowforce@21cn.com>
To: "Tang Nguyen" <tang@netoriented.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, March 25, 2004 3:35 AM
Subject: Re: APC overflow


Maybe your PCR is too small?
or you can try receice first

Regards
Li
>
> Hi all,
>
> I am porting 860sar version 2.2 on my system, which run @100Mhz for system
> clock and @50Mhz for Bus clock.  The ESAR driver was initialized very
> clean - but when I start passing UBR traffic, I always got APC overflow
> interrupt.  The physical rate of my system is 2.3MHz - and I have
configured
> the PCR to 5424 - It should be OK but I have no idea why I got APC over
flow
> interrupt.  Any help and suggestion from you would be greatly appreciated.
>
> -t
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
