Date: Thu, 9 Dec 1999 13:00:30 +0200 (EET DST)
From: Linas Nenorta IFD-5 <nenolina@pit.ktu.lt>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: NE2000 problem
In-Reply-To: <199912081904.UAA00469@piglet.grunz.lu>
Message-ID: <Pine.GSO.3.96.991209125535.13598A-100000@vejas.pit.ktu.lt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 8 Dec 1999, Michel Lanners wrote:

> On   8 Dec, this message from Linas Nenorta IFD-5 echoed through cyberspace:
> > I have IBM Power Personal Series 830 and ISA NE2000 compatible board
> > (which btw works great on x86 Linux). So I compiled 2.2.6 kernel with
> > ne2000 support but the board doesn't work. ifconfig shows TX=x errors=0
> > but RX=0 errors=y
> 
> This might not solve your problem; but do you have an up-to-date
> ifconfig? I once had erroneous stats on ionterfaces, caused by an old
> version of ifconfig interpreting some values the wrong way.
> 
> My ifconfig is from the 'net-tools-1.32.alpha-2B' RPM (don't remember
> where I got that).
>

Yes I have net-tools-1.52 
BTW once I had precompiled kernel (2.0.32 I guess) which worked fine with
that ISA Ne2000 board .. It came with PPC Redhat 4 install (FD_BOOT image)
Maybe ne2000 driver had some patches applied to it? Now with 2.2.x damn
adapter doesn't work...  

 
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


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
