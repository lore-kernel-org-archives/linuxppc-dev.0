Date: Mon, 14 Jun 2004 08:54:00 -0300
Message-Id: <HZARQ0$414F5DFF6D6EB41029999D0D02A42EB5@bol.com.br>
Subject: RE: Lite5200 from RS232 to RS485
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "saurosalomoni" <saurosalomoni@bol.com.br>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Cc: "gwilliams" <gwilliams@sbir.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I did the same thing with an 860T.  All we needed was
the RTS pin
> (inverted).  We used the standard driver and
everything worked fine.  I did
> do a little ioctl stuff but no driver changes.


The point is that the driver I'm using does not support
ioctl. What I would like to know is how to set RTS
without using ioctl.
I know there is a way, but I couldn't find it yet...


>Here is the hello file I
> started with.   Good luck
>
> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org] On
Behalf Of
> saurosalomoni
> Sent: Friday, June 11, 2004 6:35 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Cc: iida@ztec.com.br
> Subject: Lite5200 from RS232 to RS485
>
>
> Hello.
>
> I need to switch between RS232 and RS485 in my Lite5200,
>  but I realized it's a little bit more dificult than I
> thought at first...
> Well,  as far as I'm concerned, I can do that just by
> controling the RTS pin of my ttyS0 device to activate
> the 485 module (is it 100% right?).
>
> I began trying to control it with TIOCMGET/TIOCMSET
> ioctl(),  but the driver does not support hardware
> handshake.. (tahnx,  Denk)
> So now I think I'll have to write a small driver that
> uses GPIO to handle the proper PSC register.
>
> MPC5200 Users Manual states that you can set/clear the
> RTS pin with bit 7 of the OutputPort 0 (op0, offset 0x3C).
>
> My questions:
> - Is this information I gathered correct?..
> - Which PSC register I need to use to control ttyS0?
> - If it's easyer to do it by extending an existing
> driver, wich file should I look for?
> - Is there any other way to accomplish that?
>
> Thanks in advance.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
