Date: Tue, 5 Dec 2000 13:20:49 -0500 (EST)
From: Alex Avriette <alex@macachu.yi.org>
Reply-To: alex@cosmo.allay.net
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
cc: alex@cosmo.allay.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: lots of questions (va_list, embedded perl, cvsd, introduction
 - sort of)
In-Reply-To: <Pine.LNX.4.10.10012051837160.24871-100000@zirkon.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10012051319490.22364-100000@macachu.ex-pressnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


And lo there was much discussion regarding:

> No segfault. Just garbage if you use vsnprintf (which completely exhausts
> the va_list so there are no unprocessed arguments left after the call)
> twice without restoring ap in between.

thanks, franz has explained this quite a bit.

> I don't care what the maintainers of opennap claim about 'it can't run on
> Mac because Mac is broken anyway'. Writing portable code may be tough in
> this special neck of the woods, but it's possible. I've seen maintainers
> of other free software packages act reasonably about this very issue. Send
> them a patch, and explain why the patch is required.

thats what im doing here, trying to get everything figured out in the
context of the ppc so i can submit a patch and explain why.

thanks michael.

--
alex avriette [alex@cosmo.allay.net]

"No man who uses EMACS is deserving of love."
	Tom Christiansen <tchrist@perl.com>,
	_Perl Cookbook_, pp. 653


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
