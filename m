From: George Staikos <staikos@kde.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch] ignore trackpad/mouse while typing
Date: Sat, 25 Jan 2003 15:58:30 -0500
Cc: Till Straumann <Till.Straumann@TU-Berlin.de>,
	linuxppc-dev@lists.linuxppc.org
References: <3DE6C428.5000403@TU-Berlin.de> <20030125184701.A16865@ucw.cz> <1043521480.3684.32.camel@zion.wanadoo.fr>
In-Reply-To: <1043521480.3684.32.camel@zion.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301251558.30600.staikos@kde.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Saturday 25 January 2003 14:04, Benjamin Herrenschmidt wrote:
> On Sat, 2003-01-25 at 18:47, Vojtech Pavlik wrote:
> > On Thu, Nov 28, 2002 at 05:34:32PM -0800, Till Straumann wrote:
> > > OK, here's a trivial patch (linux-2.4.18) for disabling/ignoring
> > > the mouse/trackpad while typing. It can be very convenient on notebook
> > > computers.
> > > NOTE: this patch works only on machines using the 'new' input layer
> > > (e.g. Apple Powerbook, ibook, ...)
> > >
> > > The holdoff time can be adjusted via sysctl/procfs - see description
> > > in the patch file.
> >
> > It's a very nice idea, but I'd prefer this to be handled somewhere
> > higher than the IDE code, preferably in X ...
>
> Well... the problem happpens in console as well, and with other
> non-X apps like MacOnLinux. Some Apple PowerBooks have over-sensitive
> trackpad. Apple themselves implement a similar mecanism in the kernel
> driver of OS X.

  Mine is one of those machines.  I have to turn off gpm for sure, and X is
quite oversensitive too (tuned it in KDE, but still this functionality would
be very nice).

--

George Staikos


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
