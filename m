Message-ID: <3F169BAB.3090803@imc-berlin.de>
Date: Thu, 17 Jul 2003 14:50:51 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Eli Brin <elib@rokonet.co.il>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8xx SCC's as uart
References: <75DF04AC5ED4D511A9810090273CB4163F5DE7@rokonet-e.rokonet.co.il>
In-Reply-To: <75DF04AC5ED4D511A9810090273CB4163F5DE7@rokonet-e.rokonet.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eli Brin wrote:

> Dear Steven,
>
> I tested linuxppc_2_4_devel-2.4.20-2002_12_04.tar.bz2 snapshot from Denx
> ftp.
> I will get the version you referred me to.
>
> Regarding the hardware handshake, we will connect an SCC to a modem chip,
> and my tests show I need the DCD line from the modem so that mgetty (in
> autoppp mode) will detect disconnections.  It didn't detect disconnections
> without the modem handshake (DCD drop).
>
> We will try to get it working Tx.Rx only.
>

So you want to use the modem without hw flow control (RTS/CTS) ?

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
