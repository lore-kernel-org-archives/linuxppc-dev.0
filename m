Date: Thu, 1 Nov 2001 17:57:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: APUS irq patch
Message-ID: <20011101175703.A26802@cpe-24-221-152-185.az.sprintbbd.net>
References: <Pine.LNX.4.33.0111020007080.8971-100000@serv> <20011101165333.A26680@cpe-24-221-152-185.az.sprintbbd.net> <3BE1E882.6EAE635D@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BE1E882.6EAE635D@linux-m68k.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 02, 2001 at 01:27:46AM +0100, Roman Zippel wrote:

> Tom Rini wrote:
>
> > > This patch converts the irq assembly in head.S into C, the only problem is
> > > that I needed to change a prototype in <linux/irq.h>, as some additional
> > > info has to be saved/restored during an irq.
> >
> > Ack.  Won't this break other things?  I'm assuming other arches use
> > -end() too..
>
> Quite a lot actually and I don't think it's solvable before 2.5.
> It's a bit unfortunate that a architecture specific structure is in a
> general header. post_irq doesn't exist anymore (which had the pt_regs
> pointer), the only other solution would be to rename hw_interrupt_type
> and use a private version.

Well, could we accomidate APUS with some PPC-specific changes that don't
touch generic stuffs?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
