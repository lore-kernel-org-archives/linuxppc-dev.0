Date: Fri, 11 Jun 2004 10:35:02 -0300
Message-Id: <HZ5CEE$AB58D6D6E1D4B27E5EB20145E6922465@bol.com.br>
Subject: Lite5200 from RS232 to RS485
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "saurosalomoni" <saurosalomoni@bol.com.br>
To: linuxppc-embedded@lists.linuxppc.org
Cc: iida@ztec.com.br
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello.

I need to switch between RS232 and RS485 in my Lite5200,
 but I realized it's a little bit more dificult than I
thought at first...
Well,  as far as I'm concerned, I can do that just by
controling the RTS pin of my ttyS0 device to activate
the 485 module (is it 100% right?).

I began trying to control it with TIOCMGET/TIOCMSET
ioctl(),  but the driver does not support hardware
handshake.. (tahnx,  Denk)
So now I think I'll have to write a small driver that
uses GPIO to handle the proper PSC register.

MPC5200 Users Manual states that you can set/clear the
RTS pin with bit 7 of the OutputPort 0 (op0, offset 0x3C).

My questions:
- Is this information I gathered correct?..
- Which PSC register I need to use to control ttyS0?
- If it's easyer to do it by extending an existing
driver, wich file should I look for?
- Is there any other way to accomplish that?

Thanks in advance.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
