Date: Thu, 9 Dec 1999 21:40:51 +0200 (EET DST)
From: Linas Nenorta IFD-5 <nenolina@pit.ktu.lt>
To: linuxppc-dev@lists.linuxppc.org
Subject: NE2000 problem 
Message-ID: <Pine.GSO.3.96.991209213838.22053A-100000@vejas.pit.ktu.lt>
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
that ISA NE2000 board .. It came with PPC Redhat 4 install (FD_BOOT
image). Maybe ne2000 driver had some patches applied to it? Now with 2.2.x
adapter doesn't work...  

 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
