Message-ID: <000901c10df4$f1e85100$df0fa8c0@mystore>
From: "Nguyen Trung Thanh" <jari.nguyen@serialsystem.com.sg>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <3B52C152.F5FB58B7@genetel.co.kr>
Subject: PCMCIA Nokia Cardphone 2.0 for MPC823
Date: Mon, 16 Jul 2001 20:43:42 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="EUC-KR"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

Pls help me, I'm stuck with this card.
Now I used kernel Powerpc Hardhat 2.2.14,
and pcmcia-cs-3.1.21 in a custom board using
MPC823.

I could dial up with this card, but it is not stable,
and I could not transfer data such as ftp....

Furthermore, I must set the maximum value for
psst = 4, psht = 4, and psl = 20.
and add some delay between each time I read from serial port ( in function
receive_chars from file serial.c).

Have anyone done it, before? Or you have any information about thi card
phone, pls give me.

Does this card use 16550A, and follow the standard of this chip?
Is there any special thing about it spec, timing?

Thanks very much,
Jari


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
