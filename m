Date: Tue, 5 Dec 2000 12:25:13 -0500 (EST)
From: Alex Avriette <alex@macachu.yi.org>
Reply-To: alex@cosmo.allay.net
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: alex@cosmo.allay.net, linuxppc-dev@lists.linuxppc.org, max@trega.com
Subject: Re: lots of questions (va_list, embedded perl, cvsd, introduction
 - sort of)
In-Reply-To: <Pine.LNX.4.10.10012051127020.10697-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10012051221430.22364-100000@macachu.ex-pressnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


And lo there was much discussion regarding:

-snip-

> pass [4] int: 25 string: somestring
> Speicherschutzverletzung (core dumped)
>
> is what I get. On Intel, that is. gcc version is egcs-2.91.66. Seems
> something's wrong with your code in general.

well, thats the thing. there isnt, i dont think, wrong with my code (apart
from what you said earlier (later? i get this as being 15 minutes
"new"er). it doesnt segfault at all here. i get some screwed up variables,
though, in the nested_va test. however, that clearly isnt the way to run
it. the part that caught my attention is i cannot have *two* va_start
clauses in one function in the code that im running, which, like i said,
is available at opennap.sourceforge.net. i would really appreciate
somebody else giving me a heads-up on this. what i get when i ask the
other opennap developers is "that crazy ppc machine is just going to
crash, its a *mac*." i suspect there is something deeper going on here.

i will look into the __va_copy.

alex


--
alex avriette [alex@cosmo.allay.net]

"No man who uses EMACS is deserving of love."
	Tom Christiansen <tchrist@perl.com>,
	_Perl Cookbook_, pp. 653


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
