Date: Wed, 16 Jun 2004 08:49:35 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: =?Windows-1252?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hardware interrupts routines
In-Reply-To: <85E6ED5B5EC32F439702305CC417E12D9E2A80@email.3il.fr>
Message-ID: <Pine.LNX.4.44.0406160847040.10492-100000@spider.ancor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 16 Jun 2004, [Windows-1252] Garcia Jérémie wrote:
[ nnip ]
> The only hardware interrupts routine I found through my investigations
> is the request_irq(...). But the problem is that request_irq do not
> allow me to pass an argument to the handler... So is there a routine
> that allows it or is there a way to adapt the request_irq() to my case.

The last parameter of request_irq() gets passed as the second parameter
to the interrupt routine when it is called.

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
