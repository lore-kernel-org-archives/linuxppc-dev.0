Date: Fri, 13 Oct 2000 18:26:29 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>, Josh Huber <huber@mclx.com>,
        Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
In-Reply-To: <39E62C4C.42287094@student.ethz.ch>
Message-ID: <Pine.LNX.4.21.0010131549280.1099-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Oct 2000, Michel [iso-8859-1] Dänzer wrote:

> Kostas Gewrgiou wrote:
> >
> > On Thu, 12 Oct 2000, Michel [iso-8859-1] Dänzer wrote:
> >
> > > But there is an #ifdef _powerpc_ so it can't break x86 machines?
> >
> > Yes but it *does* break x86 cards used in ppc machines.
> > (linux/ppc isn't the only ppc os supported in xfree and they won't
> > be happy if we break things for them)
>
> And the int10 or whatever code works for them?

ISA IO/MEM works for them so yes int10/vgahw should be fine there, i think
that linux/ppc is the only platform with this broken (with the new syscalls
we its simple to get it working for machines with one iobase and a working
ISA memory)

> And then set info->VBIOS = NULL for OF and change the #ifdef _powerpc_ to if
> (!info->VBIOS) or similar?

Right something along this lines will do, you probably need to change the
R128_BIOS16/32 macros to do byteswapping as well since the fields in the rom
are in little endian format.

> I have my last exam for this year tomorrow and leave for two weeks of vacation
> on Saturday, so I wish good luck to any takers :)

Good luck in your exam, i'll try to write something over the weekend if i
can find some free time.

 Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
