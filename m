Date: Wed, 23 Jun 1999 09:23:37 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Kevin Puetz <kp11901@cedarnet.org>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerBook sleep, first try
In-Reply-To: <199906231305.IAA26387@www.cedarnet.org>
Message-ID: <Pine.LNX.3.96.990623091811.16972F-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 23 Jun 1999, Kevin Puetz wrote:

> Cool! Is there any hope of this working on the desktop machines that can 
> sleep? (I like my machine getting quiet when not in use, though I can live
> without.).

A desktop sleep is pretty different from a PowerBook sleep.  When a
desktop machine is asleep, it can still services network requests, and is
essentially still running, it just shuts a few things down.  The key there
is to figure out how to spin down and spin up the hard drive without
getting confused by the long delay on data access.  Then, when you do a
desktop sleep, you just cut the video sync, spin down the drives, and set
it up so that if there's any access to the drive, you spin it up long
enough to do the access, then wait a few seconds for the access to finish,
then spin back down.  Presumably, there's other stuff dealing with the
ADB, as far as shutting down other unused hardware and putting the
processor in a low speed setting or something, but I have no idea there.
Somebody else with actual cuda knowledge could probably say more in that
department.


Later,
David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
