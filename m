Message-ID: <75DF04AC5ED4D511A9810090273CB4163F5DE9@rokonet-e.rokonet.co.il>
From: Eli Brin <elib@rokonet.co.il>
To: "'Steven Scholz'" <steven.scholz@imc-berlin.de>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8xx SCC's as uart
Date: Thu, 17 Jul 2003 16:51:18 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Sure. If you don't care if data gets lost...

I would like to work on pure Tx/Rx without HW flow control.  But configuring
mgetty to work without flow control result in failure to detect disconnects.
Configuring mgetty to work with HW flow control result on detecting
disconnects.  All above experiments are on a PC.

When I will get our target, I will be able to test the HW flow control of
the 8xx and find a working mode with mgetty.  Our development targets
(TQM860L and FADS) don't have an SCC uart port...Perhaps I will try to
rewire the FADS that has SCC2 connected to an IRDA port...

Thanks for the warning... :)

Eli

-----Original Message-----
From: Steven Scholz [mailto:steven.scholz@imc-berlin.de]
Sent: Thursday, July 17, 2003 3:25 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8xx SCC's as uart



Eli Brin wrote:

>> So you want to use the modem without hw flow control (RTS/CTS) ?
> No, it depends on mgetty.
>
> I think that mgetty need hw flow control (RTS/CTS) to monitor the DCD
> line.
???
I am not sure if I understand.

>
> I can rewire (short) the RTS/CTS on each side (modem and 8xx), and
> connect only DCD.

Sure. If you don't care if data gets lost...

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
