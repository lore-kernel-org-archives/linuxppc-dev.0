Date: Wed, 3 May 2000 22:23:40 -0400 (EDT)
From: Scott Knight <scott@re-104-1.read.indiana.edu>
To: jingai <jingai@floatingpenguins.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Re: hfs
In-Reply-To: <200005040257.WAA03944@shell.faradic.net>
Message-ID: <Pine.LNX.4.10.10005032221520.13188-100000@fletch.read.indiana.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What works for you? I have the latest kernel from Paul also 2.3.99pre6 and
it most defintly does not work. I can not mount hfs cds at all. It will
let you mount hfs partitions. But try to do anything besides a ls like
specifically trying to copy something to it. And it will lock your machine
ahrd and screw up your partition. Try that out and let me know what
happens. I would think that its highly unlikely that hfs realy works for
you in the latest dec kernel.

	Scott Knight

On Wed, 3 May 2000, jingai wrote:

>
> > > Does anyone have any ideas as to why it stopped working in the first
> > > place?
> >
> > It has been broken since the introduction of the "new" page cache code
> > about a year ago in early 2.3.x. The official maintainer (A Sun of
> > netatalk fame) seems to be still alive, but nothing in terms of fixing
> > the code came from him for a year. Sometimes some changes show up in the
> > kernel trees, so that the code at least compiles, but it is still
> > broken.
>
> Maybe I'm talking about something different here, since I haven't really
> been following this thread, but as of an rsync last night, the HFS support
> in Paul's 2.3.99pre6 kernel works fine for me... it *did* quit working from
> 2.3.52 to some unknown date, but it does work now, at least for me.
>
> -j
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
