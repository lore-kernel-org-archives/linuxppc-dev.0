Date: Thu, 8 Jul 1999 16:09:24 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: "Charles A. Jolley" <charles.jolley@zeratec.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: QuickTime Streaming Server for Linux.. on x86
In-Reply-To: <199907082014.PAA19744@www2.tuckeris.com>
Message-ID: <Pine.LNX.3.96L.990708160307.5641B-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 8 Jul 1999, Charles A. Jolley wrote:
> > 
> > Also, lots and lots of "warning: multi-character character constant" coming
> > from lines like
> >
> > static const FourCharCode kFractionLostPacketsSig = 'frac';
> >
> > Should those single ticks be quotes?
> >
> > -Hollis
> 
> The MacOS makes extensive use of 4-character constants (32-bit values) to
> identify file and creator types, and also the types of resources in the
> resource fork of a file.  The single quote method is a standard way of
> indicating these constants and all MacOS compilers will take it without
> complaint.  I encountered this same problem when porting some Mac stuff to
> Linux some time ago.  I seem to recall that the compiler complained but
> produced the right results anyway.  My Linux systems are down right now so I
> can't check to make sure and I've since updated all my old code to work
> around it.

I remember that much from the very little Mac OS programming I've done... but
I was just wondering how the compiler was handling it. I mean, if I were a
compiler and I was just translating chars in 's to ascii values, I'd probably
get confused. If it's no problem, then why is it a warning?

> Changing the single ticks to quotes will most definitely introduce errors,
> though, because that will cause the compiler to produce a 32-bit pointer to
> a NULL terminated string "frac", rather than a 32-bit value equal to the
> four characters 'frac'.  This can be particularly deadly in code where types
> are explicitly cast because it is still a 32-bit value either way.

Just hoping for a quick fix... =)

Also, was the two-line patch mentioned before for LinuxPPC? Whose is it and
where is it? The darwin-streaming Apple mailing list is exceptionally dead,
and I haven't seen any mention of LinuxPPC anything on there.

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
