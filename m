Date: Tue, 26 Jun 2001 14:13:00 -0400 (EDT)
Message-Id: <200106261813.f5QID0l244185@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: lm@bitmover.com
Cc: linuxppc-commit@ppcbk.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc @ ppc.bitkeeper.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> We're working getting BK/web up and we are also making changes so that you'll
> be able to do this:
>
>         bk clone http://ppc.bitkeeper.com/linuxppc_2_4
>
> which will work through firewalls.

*sigh*

Encouraging people to violate security?

I guess everybody does it. Let's just get rid of all other ports.
Then we can all have stateful app-level firewalls to stop this
sort of hack. Admins can get regular updates, just like with their
anti-virus and Internet filter software. :-/

> While the machine we have has a gig of ram and a fast cpu, and a 1.5Mbit
> net connection, we're really prefer that you cloned once and pulled many
> times rather than recloning all the time.  Pulling uses tiny amounts of
> bandwidth, we can barely detect it, but cloning burns about 35MBytes of
> bandwidth.  It's worth getting a copy of BK even if you don't use BK
> because it can transfer the data faster than ftp/rsync/whatever because
> it already knows what has been changed.  A trivial mirroring command:
>
>         # one time only
>         bk clone bk://ppc.bitkeeper.com:5000 linuxppc_2_4
>
>         # Nightly
>         cd linuxppc_2_4
>         bk pull
>         rm -rf ../linuxppc_2_4.export
>         bk export . ../linuxppc_2_4.export

bzip2 -dc patches-are-better.bz2 | patch -p1 -E -s

I know it doesn't push BitKeeper, but patches are certainly fine for
bandwidth problems. That is, if you leave off the header crud that
BitKeeper likes to create. I think you'd save bandwidth actually.

I'm not even sure if I'm allowed to use BitKeeper. I'm doing some
work with the Linux kernel, but I can't make it public yet and
getting the paid license would be quite a pain. (while the actual
dollar amount isn't likely an issue, getting a purchase order
and MIS approval would be an awkward procedure -- around here
ClearCase rules)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
