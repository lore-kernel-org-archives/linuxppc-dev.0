Message-ID: <3A6C8044.32DEF5CE@relog.ch>
Date: Mon, 22 Jan 2001 19:47:32 +0100
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: michdaen@iiic.ethz.ch
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <3A686DFE.9030308@valinux.com> <19341214104258.22601@mailhost.mipsys.com> <3A68FC06.7BEEA13D@iiic.ethz.ch> <3A691166.DC6DCD81@iiic.ethz.ch> <3A6C6EEC.D1A84557@mvista.com> <3A6C7143.E49ADF33@relog.ch> <3A6C7DB4.516E2897@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> Michel Dänzer wrote:
>
> > No, that's not the problem, pagelist is struct page ** :-/ (and pagelist
> > is allocated)
>
> Then, what the heck were you trying to print out with that
> piece of code,

The printk's are only for debugging purposes ;)

> and who further down the food chain uses the page struct?

The DRM.


I think Roman's suggestion is very promising; There's something very
interesting in arch/ppc/mm/fault.c .


Michel


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
