Date: Mon, 19 Jan 2004 10:55:47 +0100
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040119095547.GA18112@iliana>
References: <20040118144412.GA6897@iliana> <1074443601.9704.164.camel@thor.asgaard.local> <20040118172838.GA8785@iliana> <1074450283.9700.200.camel@thor.asgaard.local> <20040118222053.GA11651@iliana> <1074468804.9700.219.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074468804.9700.219.camel@thor.asgaard.local>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 19, 2004 at 12:33:24AM +0100, Michel Dänzer wrote:
>
> On Sun, 2004-01-18 at 23:20, Sven Luther wrote:
> > On Sun, Jan 18, 2004 at 07:24:44PM +0100, Michel Dänzer wrote:
> > > On Sun, 2004-01-18 at 18:28, Sven Luther wrote:
> > > > On Sun, Jan 18, 2004 at 05:33:21PM +0100, Michel Dänzer wrote:
> > > > > On Sun, 2004-01-18 at 15:44, Sven Luther wrote:
> > > > > >
> > > > > > The freeze happens when i first launch glxinfo, or when i first start
> > > > > > moving a window around (using a debian/unstable default gnome desktop).
> > > > > > I don't remember well, but i think it would also freeze when let running
> > > > > > for a time, but i am not sure.
> > >
> > > It would be quite interesting to know, see below.
> >
> > But then, maybe it has something to do with the GL screensaver or
> > something such.
>
> Don't run them, then? *shrug*

Mmm, i only have xscreensaver installer, not the gl ones. Should be ok.

But then, the DRI server corrupts the fbdev screen, and the font memory
when i /etc/init.d/gdm stop :/

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
