Message-ID: <015c01c07fa6$17e3fd10$4a1f76d8@washington>
From: "Navin Boppuri" <nboppuri@trinetcommunication.com>
To: "Daris Nevil" <dnevil@snmc.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <011801c07f12$bf037e70$4a1f76d8@washington> <3A639801.AFF3DF00@snmc.com>
Subject: Re: Serial driver help
Date: Tue, 16 Jan 2001 10:21:30 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Daris,

Thank you for the link. But all I see there is docs on how to talk to serial
ports. I need some linux data structures info. How is serial.c organized?
How can I port a new uart to serial.c ? etc. etc. Do you know of some place
I can find this?

Thank you,
Navin Boppuri

----- Original Message -----
From: "Daris Nevil" <dnevil@snmc.com>
To: "Navin Boppuri" <nboppuri@trinetcommunication.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Tuesday, January 16, 2001 12:38 AM
Subject: Re: Serial driver help


> Navin,
>
> Check out http://www.qslinux.org/docs/snmc/serial/index.html, as it may
have
> the info that you need.
>
> Regards,
> Daris Nevil
> SNMC
>
> Navin Boppuri wrote:
>
> > Hello,
> >
> > Can someone tell me where I can find some documentation on how to write
a
> > serial driver in linux using the serial.h and tty data structures? I am
> > using MAX3100 uart connected to the SPI controller. The SPI driver is
fine
> > works just fine. I do see that uart.c is written for uarts connected on
SMC
> > and SCC. All I need to do is to port it for SPI.
> >
> > Thank you,
> > Navin Boppuri
> >
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
