Date: Mon, 8 May 2000 11:30:46 -0500 (CDT)
From: Seanano <sto9013@ksu.edu>
To: Simon Stapleton <simon@tufty.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Wallstreet Ethernet
In-Reply-To: <957801868.3916e58c8f2c3@rascal.ums.easynet.net>
Message-ID: <Pine.GSO.4.21L.0005081116020.7983-100000@unix2.cc.ksu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  Is the Wallstreet II (never heard that name) the same thing as a
lombard?  Does it have a bronze keyboard?  I've got a lombard running
2.2.15pre20 from the linuxcare linux-pmac-stable kernel source.  I haven't
had any crashes other than when I was writing a kernel module... but that
was to be expected (Note for newbie kernel module writes: make sure to
sync a few times before reading a your new (untested) /proc entry ;-)  As
far as ethernet goes, I haven't seen any problems.  I can get over 7 Megs
per second without problem.  You might check to see if your connection is
half,full, or autonegotiation on duplex.  I had problems with auto and
full on another linuxppc machine (G4 sawtooth 450). I seem to get the best
performance with setting the port on the switch to half duplex.  I'm not
sure if this is a problem with autonegotiate or what...

Hope this helps,
Sean

On Mon, 8 May 2000, Simon Stapleton wrote:

>
> Hi guys.
>
> I was wondering if any progress has been made on the Wallstreet /
> ethernet problems issue that was being discussed a while back?
>
> I'm seeing the same issues - real slow connections, a shedload
> of packet collisions and occasional crashes when the disk is
> grinding.
>
> I can probably gather some more stats if that would be helpful.
>
> Wallstreet II, kernel 2.2.14p9 (I know, I know, but it seems pretty
> stable and apart from the ethernet issue it all works),
> standard LinuxPPC 1999 install.  192MB memory, some kind of
> IBM disk.
>
> If there's a patch out there, or a newer kernel fixes it, I'd be
> grateful.  I'm a bit wary of the 2.3 kernels - I need working
> hfs as well as linux, unfortunately - but I'm willing to give
> them a go.  ISTR there was some question of whether it was the
> disk itself that was causing the problems - If that's the case
> I'll just go and shell out for an 18gig drive (not that I've been
> looking for an excuse, or anything ;-)
>
> I'd have a go at hacking the code if I had the time, but I'm working
> 18+ hour days at the moment.  Such is life <sigh>.
>
> Simon
>
> --
> Your mouse has moved.  You must reboot Windows NT for these changes to be
> recognised.
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
