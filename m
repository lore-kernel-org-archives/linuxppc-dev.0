Date: Sat, 6 Dec 2003 00:33:07 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: USB, 2.6-test11 and hot flaming death
Message-ID: <20031205233307.GA7462@ibrium.se>
References: <1070080961.683.26.camel@gaston> <09B6571B-2408-11D8-970C-0003939E069A@mac.com> <20031204163433.GA21236@ibrium.se> <1070580925.613.7.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1070580925.613.7.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Dec 05, 2003 at 10:35:26AM +1100, Benjamin Herrenschmidt wrote:
>
> > This problem has actually been present quite a while (at least
> > since 2.6.0-test3). On my dual 1.25 GHz G4, it occurs once
> > every four boots or so.
>
> Interesting. It happens with the NEC EHCI/OHCI or with the
> KeyLargo OHCI's ? I suspect it's a problem of the NEC part,
> and I think K2 actually contains that part built-in on the G5

The USB devices are all hooked up on the NEC EHCI/OHCI. I don't think the
KeyLargo OHCI cell is physically connected to any ports; it doesn't
show up in the device tree...

/Samuel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
