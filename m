Message-ID: <75DF04AC5ED4D511A9810090273CB4163F5DE8@rokonet-e.rokonet.co.il>
From: Eli Brin <elib@rokonet.co.il>
To: "'Steven Scholz'" <steven.scholz@imc-berlin.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: 8xx SCC's as uart
Date: Thu, 17 Jul 2003 16:01:27 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


No, it depends on mgetty.

I think that mgetty need hw flow control (RTS/CTS) to monitor the DCD line.

I can rewire (short) the RTS/CTS on each side (modem and 8xx), and connect
only DCD.

Eli


-----Original Message-----
From: Steven Scholz [mailto:steven.scholz@imc-berlin.de]
Sent: Thursday, July 17, 2003 2:51 PM
To: Eli Brin
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8xx SCC's as uart


Eli Brin wrote:

> Dear Steven,
>
> I tested linuxppc_2_4_devel-2.4.20-2002_12_04.tar.bz2 snapshot from
> Denx ftp. I will get the version you referred me to.
>
> Regarding the hardware handshake, we will connect an SCC to a modem
> chip, and my tests show I need the DCD line from the modem so that
> mgetty (in autoppp mode) will detect disconnections.  It didn't detect
> disconnections without the modem handshake (DCD drop).
>
> We will try to get it working Tx.Rx only.
>

So you want to use the modem without hw flow control (RTS/CTS) ?

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
