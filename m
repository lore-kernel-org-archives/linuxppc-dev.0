Date: Tue, 12 Sep 2000 11:09:33 -0400 (EDT)
From: mberglund <matt@realestatesafari.com>
To: Graham Stoney <greyham@research.canon.com.au>
Cc: Michel Dänzer <daenzerm@student.ethz.ch>, Todd Lipcon <tlipcon@mercea.net>,
        "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Roles for distributions
In-Reply-To: <20000912042454.D7D1F208@elph.research.canon.com.au>
Message-ID: <Pine.LNX.4.21.0009121053310.832-100000@europa.rcinfo.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 12 Sep 2000, Graham Stoney wrote:

>
> Michel =?iso-8859-1?Q?D=E4nzer?= writes:
> > I think it's better to pick something which doesn't work and you would like it
> > to, then start digging into it instead of looking for 'the right one which
> > needs help the most' where you aren't in it with your heart and soul. :)
>
> This is good advice, but it's only half the problem -- and it's the relatively
> easy half at that.  I found that kernel profiling for ppc in v2.2 didn't work
> for me (didn't work at all in fact), so I fixed it and published the patch all
> over the place, including at:
>     http://members.nbci.com/greyhams/linux/patches/2.2/profile.patch
>
> However, the intractible part is getting my fix into the official sources.
> I'm not working for a distribution; maybe it would be easier if I was.
> I'm just a user who doesn't want to have to keep reapplying my patches every
> time I get a new release, and would like to fix stuff properly so the next
> guy who comes along has an easier time than I did.  It's not at all clear how
> to get fixes in even once you've dug up the solution.

You guys are discussing some of the issues our group (of two) would like
to rectify. This is an on-going problem, and I think part of it has to do
with the fact that there is not a "non-commercial" distribution going. We
have been working on a system which offers a bunch of admin functionality
that the commercial guys will probably never do, because it will take
revenue away from them. These guys are not going to implement any idea
that might cause them a little damage, even if the idea is good. At
apachecon in orlando last year a SUSE rep said that the kind of update we
were suggesting would cause cd sales to go down, so there was "no way" it
would ever get implemented. To easy to do updates over the web.

If we can get this thing off the ground it will serve as a central place
for many of the patches and system ideas that people would like to see in
some of the other distros, but without the problem of sending a little
patch to Linus or Alan, here and there. We can get our acts together as a
group, and the submit more complete, better tested stuff, and this is only
in the kernel. Imagine how nice it would be to keep the userland software
in sync with the system changes. some of the distro's do a good job of it,
but why can't a group of individuals do it like FreeBSD does?

It just seems to me that a group of people who actually care about the
system can write a better system than most of the paid professionals out
there (not to knock the paid professionals).

Just a thought,
Matt
matt@fxp.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
