Date: Thu, 9 Sep 1999 22:07:53 -0500 (CDT)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ioremap (still?) broken
In-Reply-To: <199909090629.IAA00320@piglet.cpu.lu>
Message-ID: <Pine.LNX.4.04.9909092206020.5581-100000@narn.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



A couple of people mentioned I should check that PCI memory accesses are
enabled in the PCI command register. I fixed this, and about an hour later
I was transmitting at around 300 Mbit/second ;)

Thanks to all who replied.



On Thu, 9 Sep 1999, Michel Lanners wrote:

> On   7 Sep, this message from Troy Benjegerdes echoed through cyberspace:
> [about an Alteon PCI Gigabit card]
> > The first thing the driver does is check the card version by reading a
> > particular register. By using appropriate printf's, I have found that the
> > value returned is '0xffffffff'. (defininitely NOT the register it's
> > looking for)
> 
> First, I'd try to get the card identification right. What kind of
> register are you trying to read? Is that a PCI config register, or
> already a memory- or IO-register on the card?
> 
> What about lspci? Does it report your board? Does it identify it
> correctly? In what machine are you trying this?
> 
> Get back with this, and we'll see for the next step ;-)
> 
> Michel
> 
> -------------------------------------------------------------------------
> Michel Lanners                 |  " Read Philosophy.  Study Art.
> 23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
> L-1710 Luxembourg              |
> email   mlan@cpu.lu            |
> http://www.cpu.lu/~mlan        |                     Learn Always. "
> 
> 

--------------------------------------------------------------------------
| Troy Benjegerdes    |  troy@blacklablinux.com    |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
