Subject: Re: USB, 2.6-test11 and hot flaming death
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Samuel Rydh <samuel@ibrium.se>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031205233307.GA7462@ibrium.se>
References: <1070080961.683.26.camel@gaston>
	 <09B6571B-2408-11D8-970C-0003939E069A@mac.com>
	 <20031204163433.GA21236@ibrium.se> <1070580925.613.7.camel@gaston>
	 <20031205233307.GA7462@ibrium.se>
Content-Type: text/plain
Message-Id: <1070759378.12499.15.camel@gaston>
Mime-Version: 1.0
Date: Sun, 07 Dec 2003 12:09:39 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-12-06 at 10:33, Samuel Rydh wrote:
> On Fri, Dec 05, 2003 at 10:35:26AM +1100, Benjamin Herrenschmidt wrote:
> >
> > > This problem has actually been present quite a while (at least
> > > since 2.6.0-test3). On my dual 1.25 GHz G4, it occurs once
> > > every four boots or so.
> >
> > Interesting. It happens with the NEC EHCI/OHCI or with the
> > KeyLargo OHCI's ? I suspect it's a problem of the NEC part,
> > and I think K2 actually contains that part built-in on the G5
>
> The USB devices are all hooked up on the NEC EHCI/OHCI. I don't think the
> KeyLargo OHCI cell is physically connected to any ports; it doesn't
> show up in the device tree...

Ok, so something is wrong between those old Apple kbds and the NEC
part... Interesting. Does MacOS X show any similar symptom ? Also,
I suppose we could fix the OHCI driver to at least try to recover
in this case... I don't have much time to play with this at the
moment, but I'll keep that in mind. I need to find one  of those
bad kbds first ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
