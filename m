Message-ID: <3C0D06F8.57DD8837@mvista.com>
Date: Tue, 04 Dec 2001 09:25:12 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Phil <ibm405.linux@laposte.net>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Matt Porter <mporter@mvista.com>,
	Simon Winwood <sjw@cse.unsw.edu.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: More walnut boottime "fun"
References: <20011127103042.A11612@cse.unsw.edu.au> <20011126221728.D13091@cpe-24-221-152-185.az.sprintbbd.net> <20011127050754.B15728@cx258813-a.chnd1.az.home.com> <3C0CD3C6.ECB0E61B@laposte.net> <20011204141147.GD17651@cpe-24-221-152-185.az.sprintbbd.net> <3C0CDCB1.9F3A9423@laposte.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Phil wrote:
>
> I resync the kernel sources today at 7:15 am GMT.
> Any idea ?
>
> -Phil.
>
> Tom Rini a écrit :
> >
> > On Tue, Dec 04, 2001 at 02:46:46PM +0100, Phil wrote:
> >
> > > I'am trying to boot the latest linuxppc_2_4_devel kernel version
> > > (2.4.27-pre2).
> >
> > What date?  This isn't a problem anymore, at least on a few walnuts I've
> > gotten people to test.

Rev 1.731 of linuxppc_2_4_devel(mid-day California time yesterday) boots
fine on my walnut.

HHL2.0 toolchain and ibm OpenBios.

I used an almost default configuration (I was working on a KGDB
problem so I enabled KGDB):

   make walnut_config
   make menconfig
        select KGDB
        select CONFIG_MORE_COMPILE_OPTIONS
   make dep
   make zImage

(I needed to fix config.in to allow CONFIG_MORE_COMPILE_OPTIONS - see
the patch I posted yesterday.)

You shouldn't have to enable KGDB.


Do you have KGDB enabled by mistake?  If you do, it will sit at the
"Now booting the kernel" console message until KGDB connects to the
target.


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
