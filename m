Date: Wed, 13 Feb 2002 13:09:45 -0800 (PST)
From: "David A. Gatwood" <dgatwood@gatwood.net>
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: G4 boot crash problems with 2.4 "stable"
In-Reply-To: <20020213190744.31608@mailhost.mipsys.com>
Message-ID: <Pine.LNX.3.96.1020213125526.27925B-100000@gatwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Feb 2002 benh@kernel.crashing.org wrote:

> >Is there a 2.4 kernel source tarball around that is known to boot on
> >Sawtooth (using BootX)?  Is there a way to yank the OpenPIC support?
>
> BootX isn't supported on any newworld mac. You should boot from OF,
> using yaboot.

BootX works fine for me with every 2.2 kernel I've tried.  It only fails
for 2.4 TOT builds.  I very much doubt the boot mechanism is at fault.


Later,
David

---------------------------------------------------------------------
                    Check out my weekly web comic:
                     http://www.techmagazine.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
