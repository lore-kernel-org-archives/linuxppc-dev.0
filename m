From: Brad Boyer <flar@marcus.pants.nu>
Message-Id: <199911150850.AAA12382@marcus.pants.nu>
Subject: Re: Would HFS+ read only capability be useful?
To: dave@thinbits.com (Dave Camp)
Date: Mon, 15 Nov 1999 00:50:51 -0800 (PST)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199911140940.BAA29983@easystreet01.easystreet.com> from "Dave Camp" at Nov 14, 99 01:40:50 am
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dave Camp wrote:
> Since HFS+ development seems to be stalled, I was thinking of throwing my 
> hat in the ring. Now, before you call me crazy...

Actually, I got sick of waiting as well, and there are some other people who
I have talked to at various points.  I don't have hardly any code written,
but I have taken a lot of time, and I think I understand VFS pretty well.

> I've got the HFS+ spec. I've got code I wrote for MacOS that was going to be
> used for a disk repair program I was working on, but has been put on hold
> due to a lack of free time to complete it. The code implements objects for
> reading/manipulating the bitmap, volume header, both B*Tree's, extent lists,
> HFS wrapper volumes, etc. It also has a nice caching system built into it.

Depending on how it was written, it may be useful, but it may not.  Just remember
that if your code isn't GPL, it can't be directly used in the kernel.  If I get
some time soon, I'll set up some web pages with what I already have, and
people can help.  Since most of what I have at the moment is just in my head,
there isn't much to put on the net, but I'll try.

> There is enough code, I would think, to implement read only data fork access
> for HFS+ volumes without much trouble.
> 
> Problem is, I don't know anything about Linux coding, or more specifically,
> what the API looks like for adding a file system module (or whatever the
> proper term is).

Well, the hardest part I've found so far is the interfacing with the system,
athough understanding Apple's BTrees is a very close second.

> Would this be useful? If so, can someone suggest a book or two on coding in
> this area of Linux? Also, are there Unicode API's in Linux (since HFS+ uses
> Unicode to store filenames)?

As far as I know, there are no printed books on this topic, although there is
a book about device drivers.  The best option is the LDP or the kernel source
itself.  The kernel comes with a short description of VFS in the Documentation
directory, but it isn't very informative.  Mostly just a list of functions and
structures.  I learned from reading the kernel source, mostly.  There is some
Unicode support in the kernel for some of the MS filesystems, but I don't have
a good understanding of Unicode, so I can't really say how useful it is without
actually trying it.

	Brad Boyer
	flar@pants.nu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
