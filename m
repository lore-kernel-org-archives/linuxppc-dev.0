Message-ID: <002801c15928$1782da60$df80a984@serial>
Reply-To: "Nguyen Trung Thanh" <jari.nguyen@serialsystem.com.sg>
From: "Nguyen Trung Thanh" <jari.nguyen@serialsystem.com.sg>
To: "Kil-Joon Park" <beast@rtp.gsnu.ac.kr>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <200110191451.XAA15898@rtp.gsnu.ac.kr>
Subject: Re: PCMCIA on MPC823e
Date: Sat, 20 Oct 2001 13:28:46 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Let me talk about my own experimence, that the same as my lastest mail about
this RPX-Lite and PCMCIA problem.

Last time, I'm stuck with RPX-Lite and PCMCIA Nokia Cardphone2.0.
The result is the design of this board is not compatible with this card.
This card and several PCMCIA cards (pls check yours) are affected by for
signals: IORD, IORW, OE and WE when ChipSelect is inactive. And the RPX-Lite
board do not isolate those four signals when ChipSelect is inactive.

Of course, that is the worst case, pls check yours code first to make sure
that code could work with other PCMCIA cards.

Furthermore, last time I used a bus anlyzer to detect that problem.
Best regards,
Jari Nguyen Trung Thanh

----- Original Message -----
From: "Kil-Joon Park" <beast@rtp.gsnu.ac.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, October 19, 2001 10:51 PM
Subject: PCMCIA on MPC823e


>
> Target System : Embedded Planet Linux Planet (MPC823e, RPX LITE), kernel
2.4.4
>
> I would like to use a PCMCIA ethernet card on the target system.
>
> I tried to install pcmcia-cs-3.1.28 package, but failed...
>
> Is the patch needed? Where do I get the patch?
>
> Please help me.... ^^;
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
