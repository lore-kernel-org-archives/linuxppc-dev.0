Message-ID: <009501c453ad$b6be50f0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Bret Indrelee" <Bret.Indrelee@qlogic.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.LNX.4.44.0406160847040.10492-100000@spider.ancor.com>
Subject: Re: Hardware interrupts routines
Date: Wed, 16 Jun 2004 10:24:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


But isn't he going to have to write a device driver in order to call
request_irq()?  You can't just call request_irq() from an application, can
you?  If not, is there any way to grab an interrupt other than writing a
device driver?

Mark Chambers

----- Original Message -----
From: "Bret Indrelee" <Bret.Indrelee@qlogic.com>
To: "Garcia Jérémie" <GARCIAJ@3il.fr>
> On Wed, 16 Jun 2004, [Windows-1252] Garcia Jérémie wrote:
> [ nnip ]
> > The only hardware interrupts routine I found through my investigations
> > is the request_irq(...). But the problem is that request_irq do not
> > allow me to pass an argument to the handler... So is there a routine
> > that allows it or is there a way to adapt the request_irq() to my case.
>
> The last parameter of request_irq() gets passed as the second parameter
> to the interrupt routine when it is called.
>
> -Bret
>
> --
> Bret Indrelee                 QLogic Corporation
> Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN
55346
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
