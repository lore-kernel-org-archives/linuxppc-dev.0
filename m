From: jcarr@mail.linuxppc.org
Date: Fri, 10 Nov 2000 16:53:32 -0600 (CST)
To: Ethan Benson <erbenson@alaska.net>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Example miboot on new world rom problem
In-Reply-To: <20001109172843.G4577@plato.local.lan>
Message-ID: <Pine.LNX.4.21.0011101549510.3138-100000@jcarr.linuxppc.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> setup a 800K Apple_Bootstrap partition where the newworld bootstrap is
> installed, that will solve your problem.  if you put it first you
> don't need to do anything to OpenFirmwares configuration, just reset
> it to defaults.

Ok. That sounds workable. Is that what OSX does also? If so, will it
conflict?

> making yaboot load macos would be non-trivial.  however with current

True!


> > In the other case, miBoot needs to have the ability to change the
> > boot-device if it detects that it is running on a New World ROM
> > machine. Maybe Harry Eaton or Mike Tesch are still around and can help
> > grok bootvars code to add to miboot?
>
> miboot needs alot of things...  simplest way to deal with this is
> don't install miboot on a newworld!  we don't install lilo on sparcs
> or silo on x86 boxes afterall.

Well, I think that the macos will not like the system folder unless it has
a system file. But whatever we put in the system folder as the system
file, we will still have the problem we were having:

Anyone that has a partition visable to the macos and trys to boot off of
it will still get miboot. And, I think, It will be hard to get people not
to expect that to work.
Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
