Date: Sat, 25 Jan 2003 22:29:02 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
	Till Straumann <Till.Straumann@TU-Berlin.de>,
	linuxppc-dev@lists.linuxppc.org, George Staikos <staikos@kde.org>
Subject: Re: [patch] ignore trackpad/mouse while typing
Message-ID: <20030125222902.A18919@ucw.cz>
References: <3DE6C428.5000403@TU-Berlin.de> <20030125184701.A16865@ucw.cz> <1043521480.3684.32.camel@zion.wanadoo.fr> <200301251558.30600.staikos@kde.org> <20030125220422.A18276@ucw.cz> <1043529955.3683.41.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1043529955.3683.41.camel@zion.wanadoo.fr>; from benh@kernel.crashing.org on Sat, Jan 25, 2003 at 10:25:56PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 25, 2003 at 10:25:56PM +0100, Benjamin Herrenschmidt wrote:

> > > > Well... the problem happpens in console as well, and with other
> > > > non-X apps like MacOnLinux. Some Apple PowerBooks have over-sensitive
> > > > trackpad. Apple themselves implement a similar mecanism in the kernel
> > > > driver of OS X.
> > >
> > >   Mine is one of those machines.  I have to turn off gpm for sure, and X is
> > > quite oversensitive too (tuned it in KDE, but still this functionality would
> > > be very nice).
> >
> > How about implementing it in mousedev.c?
>
> Right, though it would need hooks in kbddev or something to know
> about keystrokes.

It could accept keyboards as an event source for this purpose. I'd like
to keep this out of the input core.

> Also, I don't like the sysctl's as those need
> allocating sysctl numbers, which are always a problem. In 2.5,
> we could have these in sysfs, though for 2.4 I'm not sure what
> to do.

I don't think you can do much better than sysctl or module parameters in 2.4.

--
Vojtech Pavlik
SuSE Labs

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
