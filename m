Date: Thu, 31 Dec 1998 14:59:23 -0600 (CST)
From: Tom Rini <trini@globe.linuxppc.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: temporary freeze with Debian init
In-Reply-To: <Pine.LNX.4.03.9812311928100.21390-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.3.96.981231145628.528A-100000@globe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 31 Dec 1998, Geert Uytterhoeven wrote:

> On Thu, 31 Dec 1998, Tom Rini wrote:
> > On Thu, 31 Dec 1998, Geert Uytterhoeven wrote:
> > 
> > >     NET3: Unix domain sockets 0.16 for Linux NET3.038.
> > 
> > Unix domain sockets as a module perhaps?
> 
> Yes. But it's module on my m68k box too, and there I don't see the problem.

Might be worth seeing if kmod is doing something odd for us.  It's not a
debian problem I can say that much.  I think I've seen kmod's thread get
stuck in a loop trying to find a moduleat boot sometimes to.

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
