Message-Id: <199909090629.IAA00320@piglet.cpu.lu>
Date: Thu, 9 Sep 1999 08:29:11 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: ioremap (still?) broken
To: hozer@drgw.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.04.9909070126490.14821-100000@narn.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   7 Sep, this message from Troy Benjegerdes echoed through cyberspace:
[about an Alteon PCI Gigabit card]
> The first thing the driver does is check the card version by reading a
> particular register. By using appropriate printf's, I have found that the
> value returned is '0xffffffff'. (defininitely NOT the register it's
> looking for)

First, I'd try to get the card identification right. What kind of
register are you trying to read? Is that a PCI config register, or
already a memory- or IO-register on the card?

What about lspci? Does it report your board? Does it identify it
correctly? In what machine are you trying this?

Get back with this, and we'll see for the next step ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
