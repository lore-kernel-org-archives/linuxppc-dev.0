Date: Tue, 18 May 1999 09:17:32 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: OF booting news
In-Reply-To: <19990515100909.001740@mail.mipsys.com>
Message-ID: <Pine.SUN.4.02.9905180911500.14119-100000@sea.ntplx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 15 May 1999, Benjamin Herrenschmidt wrote:

> For those who haven't seen it yet, with Darwin 0.2, Apple release new
> pieces of source code, including the secondary loader, with sources, a
> working of control video driver, and more... That's interesting because
> we should now be able to make a great secondary booter with OS choosing
> capabilities. I don't have time to look into this now, but this could be
> a good replacement for BootX in the future.

It looks like most part of the MkL booter were canablized in this as well.
So it should be possible to do the following, with a little work:
On old (not New World) ROMs, choose between: MacOS, LinuxPPC, MkL (little
bit of work on their end?), possibly BeOS, *BSD, and and OSX.  On New
World, most of that is possible (some problem OF booting LPPC right now,
and No MacOS (w/o lots of work).)  All that's really missing from it right
now is some graphical part I think.  There's a routine to draw the OSX
logo tho. :)

--
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
