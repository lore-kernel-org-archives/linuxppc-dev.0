Message-Id: <200005040257.WAA03944@shell.faradic.net>
Date: Wed, 03 May 2000 22:57:37 EDT
From: jingai <jingai@floatingpenguins.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Re: hfs
Reply-To: jingai@floatingpenguins.com
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Does anyone have any ideas as to why it stopped working in the first
> > place?
>
> It has been broken since the introduction of the "new" page cache code
> about a year ago in early 2.3.x. The official maintainer (A Sun of
> netatalk fame) seems to be still alive, but nothing in terms of fixing
> the code came from him for a year. Sometimes some changes show up in the
> kernel trees, so that the code at least compiles, but it is still
> broken.

Maybe I'm talking about something different here, since I haven't really
been following this thread, but as of an rsync last night, the HFS support
in Paul's 2.3.99pre6 kernel works fine for me... it *did* quit working from
2.3.52 to some unknown date, but it does work now, at least for me.

-j

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
