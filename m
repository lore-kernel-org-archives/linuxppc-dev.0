Date: Fri, 4 Aug 2000 14:44:26 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Tom Gall <gall@rochcivictheatre.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Getting things in...  Was: Re: shifts on 64bit ints
In-Reply-To: <398B10DE.FE82BA4A@ivey.uwo.ca>
Message-ID: <Pine.A41.3.96LJ1.1b7.1000804141249.33624C-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 Aug 2000, Hendricks, Kevin wrote:

> > I'm not really against the web site idea, but it's just that there won't
> > be too many people submitting patches in the first place to warrent the
> > extra administrative burden on developers with write access to BK, I would
> > think.
>
> I don't agree.  A separate website is important.  I don't work on the kernel
> directly but I have submitted patches here and there and have run into problems
> when testing/debugging the JDK that are kernel issues.

Ok, on a second thought, I feel a patch repository is a good idea for
users.  I was originally not too excited about the idea because people who
actually make the final decisions like Cort or Paul haven't said anything,
and I'm not really positive that they can spend time on dealing with the
patches accumulated in the repository in timely manner.  Unless we have
their blessing, the repository won't work for many of the patches, and
we'll have to default to current method of non-method.  [Well, at least
Ben is willing, so I'm sure the repository will work for pmac specific
patches, actually.]  However, the repository will be good for users who
compile kernels themselves or distribution makers.  They can search for
fixes for specific problems they are facing, and we can point users to
look at the repository for patches.

>
> I don't want write access to any tree, but I do need to see what patches are
> going in, what changed, the status of my own patches, etc.
>
> Also, I think we could easily modify any of the simple bugdatabase programs like
> bugzilla to do exactly what we want (instead of calling them bugs, call them
> patches, instead of fixed, call them accepted, etc)  You could also create
> categories so that driver patches are separate from other patches easily with
> this type of software.

I agree.  It should be fairly easy to set up.

> We are getting more and more people contributing to the kernel process

I feel it's not many more than ten at any given time, if we only count
kernel hackers without the write access who submit patches occasionally or
regularly.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
