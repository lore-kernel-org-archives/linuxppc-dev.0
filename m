Message-ID: <3B532093.4010004@mvista.com>
Date: Mon, 16 Jul 2001 10:12:51 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Nguyen Trung Thanh <jari.nguyen@serialsystem.com.sg>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA Nokia Cardphone 2.0 for MPC823
References: <3B52C152.F5FB58B7@genetel.co.kr> <000901c10df4$f1e85100$df0fa8c0@mystore>
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Nguyen Trung Thanh wrote:

> Hi all,
>
> Pls help me, I'm stuck with this card.
> Now I used kernel Powerpc Hardhat 2.2.14,
> and pcmcia-cs-3.1.21 in a custom board using
> MPC823.


You should consider moving to 3.1.26, many bugs have been fixed.

>
> I could dial up with this card, but it is not stable,
> and I could not transfer data such as ftp....
>
> Furthermore, I must set the maximum value for
> psst = 4, psht = 4, and psl = 20.
> and add some delay between each time I read from serial port ( in function
> receive_chars from file serial.c).


In general, there are conflicts between 8xx serial driver (uart.c) and
serial.c.  They may be stepping on each other.

>
> Have anyone done it, before? Or you have any information about thi card
> phone, pls give me.
>
> Does this card use 16550A, and follow the standard of this chip?
> Is there any special thing about it spec, timing?
>
> Thanks very much,
> Jari
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
