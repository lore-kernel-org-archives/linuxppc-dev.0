Subject: Re: Patch for arch/ppc/kernel/head.S - require version update
To: rodneyd@nulec.com.au (Rodney Davies)
Date: Fri, 28 Apr 2000 12:14:04 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1072F1A27E99D3119747005004B9A3804157C8@MAIL> from "Rodney Davies" at Apr 28, 2000 09:26:39 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000428021405.349EEE2@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Rodney,

Rodney Davies writes:
> I'm currently in the process of trying to patch the 2.2.13
> /arch/ppc/kernel/head.S file with Jason's update (11/04/2000)(see below),
> however, I have a much older version of head.S than what the patch is
> expecting --
>
> I have -
> $Id: head.S,v 1.130.2.6 1999/10/12 01:03:34 Cort
>
> The patch says -
> - $Id: head.S,v 1.1.1.1 2000/01/03 15:56:48 jason Exp $
> + $Id: head.S,v 1.4 2000/04/11 18:59:54 jason Exp $

This is because Jason is using cvs to track changes, and it replaced the
original "Cort" 1.130.2.6 $Id string with a "jason" 1.1.1.1 one from the date
he imported it locally. It doesn't mean that the rest of the file is
necessarily different, and he stated that the diff is against the one in
mpc8xx-2.2.13.

Patch should reject this first hunk when you go to apply it, but all the
others should apply OK; otherwise, you've got a problem.

> ...or could I be really dangerous and fudge the current head.S file I have
> to make the new patch *think* it's the 2000/01/03 version....I really don't
> have a clue as to what changes/additions/subtractions that have taken place
> between October and January...

You don't have to fudge it. Just ignore the fact the the first hunk doesn't
apply.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
