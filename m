To: jmouro@iol.pt
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA polling!?! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Jun 2003 10:15:57 BST."
             <5f23aa5f1089.5f10895f23aa@iol.pt>
Date: Thu, 12 Jun 2003 12:09:17 +0200
Message-Id: <20030612100922.26927C5FD7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <5f23aa5f1089.5f10895f23aa@iol.pt> you wrote:
>
> in fact the system I'm working in,
> uses the PCMCIA input ports as general purpose input ports.

I see.

> Can the system use edge detection and interrupt capability (on those 2 li
> nes - IPA6 IPA7) or shall it perform a polling.

I already answered this question:

> > CBBVD1/2  (Battery  Voltage  Detect 1 and 2). Interrupts can be abled
> > individualy for each of the 4 pins in  the  PCMCIA  Interface  Enable
> > Register.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The one who says it cannot be done should never interrupt the one who
is doing it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
