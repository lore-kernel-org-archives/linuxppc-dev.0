Subject: Re: Roles for distributions
To: daenzerm@student.ethz.ch (Michel Ddnzer)
Date: Tue, 12 Sep 2000 15:24:54 +1100 (EST)
Cc: tlipcon@mercea.net (Todd Lipcon),
        khendricks@ivey.uwo.ca (Kevin B. Hendricks),
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39BD4563.A9EFD09B@student.ethz.ch> from "Michel Ddnzer" at Sep 11, 2000 10:49:39 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000912042454.D7D1F208@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel =?iso-8859-1?Q?D=E4nzer?= writes:
> I think it's better to pick something which doesn't work and you would like it
> to, then start digging into it instead of looking for 'the right one which
> needs help the most' where you aren't in it with your heart and soul. :)

This is good advice, but it's only half the problem -- and it's the relatively
easy half at that.  I found that kernel profiling for ppc in v2.2 didn't work
for me (didn't work at all in fact), so I fixed it and published the patch all
over the place, including at:
    http://members.nbci.com/greyhams/linux/patches/2.2/profile.patch

However, the intractible part is getting my fix into the official sources.
I'm not working for a distribution; maybe it would be easier if I was.
I'm just a user who doesn't want to have to keep reapplying my patches every
time I get a new release, and would like to fix stuff properly so the next
guy who comes along has an easier time than I did.  It's not at all clear how
to get fixes in even once you've dug up the solution.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
