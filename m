To: Tom Rini <trini@kernel.crashing.org>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 17 Jun 2002 10:35:50 PDT."
             <20020617173550.GV13541@opus.bloom.county>
Date: Mon, 17 Jun 2002 22:23:02 +0200
Message-Id: <20020617202307.DD107102FB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Tom,

in message <20020617173550.GV13541@opus.bloom.county> you wrote:
>
> > You shouldbe aware of all the problems with 2.5 for 8xx systems
>
> Yes.  There's 2 right now.  The tlb miss handlers need to be updated
> because the pmd is now a physical address rather than a virtual one, and
> the exception handling needs to be updated for some changes Paul made
> recently.   Everything else should be OK.

There is one central problem: this source  tree  is  an  experimental
tree, and it's far from being stable.

It makes no sense to me to use 2.5 as base for any of our daily work.

> Well, for the moment I'd like to try that.  Considering there's really 4
> (kernel.org, linuxppc_2_4, linuxppc_2_4_devel, DENX) trees people use right
> now, I'd like to try and remove at least one of those.

Agreed. I would be more than happy  to  get  rid  of  the  effort  to
maintain  our tree. But there are so many things I've submitted again
and again that never got acceepted that I gave  up.  [And  I  am  NOT
talking  about  obviouslu  controversial  stuff  like  our  old flash
drivers.]

> And since we're stuck between a rock and a hard place, wrt killing
> 2_4_devel right now, lets use linuxppc-2.5 (or linux-2.5) which has
> 98% of the changes in _devel (and I think 100%, wrt 8xx).

This does not work. When we port Linux to any new board,  we  need  a
stable  base  in  the  first place. Right now we're in the process of
switching to 2_4_devel, because this finally seems mature enough. 2.5
is nice for trying out new features and  stuff  like  that,  but  for
cleanup,  and  regular extensions (like new board support stuff etc.)
it's a wasto of time to get an instable tree like 2.5  running  on  a
new system just to get the patches into the "real" tree where we need
them  -  which  also  may take a LONG time (or forever), judging from
previous experience.

> Fixing 2 things.  And it will be a lot less painful now trying to fix 2,
> recently broken things, rather than waiting 6 months to fix 5 or 10
> broken things spanning 6-8 months.

For my purposes, 2.5 is not usable (yet). It's a playground.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Old programmers never die, they just branch to a new address.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
