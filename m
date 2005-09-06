Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <B6241EC1-429C-4286-BCF0-E0D3DC5049BF@freescale.com>
References: <200509020518.32732.arnd@arndb.de>
	<B6241EC1-429C-4286-BCF0-E0D3DC5049BF@freescale.com>
Content-Type: text/plain
Message-Id: <1126039597.25148.59.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 06 Sep 2005 15:46:38 -0500
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH Merge more include files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-09-02 at 08:38, Kumar Gala wrote:
> On Sep 1, 2005, at 10:18 PM, Arnd Bergmann wrote:
> 
> > On Dunnersdag 01 September 2005 22:51, Jon Loeliger wrote:
> >
> >> +/*
> >> + * This file is included by 'init/main.c' to check for
> >> + * architecture-dependent bugs.
> >> + */
> >> +
> >> +extern void check_bugs(void);
> >> +
> >>
> >
> > Actually, I think this could to be
> >
> > +static inline void check_bugs(void)
> > +{
> > +}
> >
> > The function is empty on both ppc and ppc64, so we can just as
> > well get rid of the symbol as well.
> > The rest of the patch looks perfect to me.
> 
> We just have to make sure to get ride of the implementation in arch/ 
> ppc*/kernel/syscalls.c if we do this.
> 
> - kumar

Arnd,

If you'd like, I'll submit a patch to use the static inline
variant and rip out the definiton in the syscalls.c files.

jdl
