Date: Fri, 25 Jan 2002 10:11:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: arch/ppc/kernel/setup.c::screen_info
Message-ID: <20020125171143.GG745@cpe-24-221-152-185.az.sprintbbd.net>
References: <20020125164406.GF745@cpe-24-221-152-185.az.sprintbbd.net> <Pine.GSO.4.21.0201251754440.15996-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0201251754440.15996-100000@vervain.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 25, 2002 at 05:55:34PM +0100, Geert Uytterhoeven wrote:
>
> On Fri, 25 Jan 2002, Tom Rini wrote:
> > On Fri, Jan 25, 2002 at 05:28:21PM +0100, Geert Uytterhoeven wrote:
> > > On Fri, 25 Jan 2002, Tom Rini wrote:
> > > > Right.  The problem is that exporting a module symbol based on CONFIG_
> > > > option is bad taste.  I'd rather not do it based on FB_VGA16_MODULE ||
> > > > FB_VESA_MODULE :)
> > >
> > > I'd really like to get rid of the screen_info. It's some kind of
> > > `residual data', filled in with values passed by the BIOS (on ia32).
> >
> > Perhaps we can in 2.5 as part of the fb rewrite that's going on.  But I
> > don't think it's an option for 2.4, do you?
>
> Indeed not for 2.4.x.
>
> Note that it's not pure fb-related, since vgacon relies heavily on screen_info.

Right.  I thought I mentioned that, but forgot.  vgacon is a bool
anyhow, so we don't need to export it as a symbol, just have it exist.
:)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
