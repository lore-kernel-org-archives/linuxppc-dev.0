Message-Id: <v04003a03b7cffac9bde2@[24.70.162.28]>
In-Reply-To: <3BAA363B.5010400@mc.com>
References: <20010920171002.37DCA2B54A@marcus.pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 20 Sep 2001 15:01:52 -0500
To: Mark Salisbury <mbs@mc.com>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: ppc LE questions (seeking help hand info pointers)
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:32 PM -0500 9/20/01, Mark Salisbury wrote:
[...]
>when dealing w/ direct mapped, shared memory, uniformity of endian-ness
>makes many multicomputer problems easier to solve.(not to mention easier
>for the customer to program...)
[...]

Endian-safe code isn't terribly difficult to write. The PPC even has some
very nice little-endian load and store operations which are easily
accessable in big-endian mode, and obviously don't carry any of the baggage
of running in le mode.

Not to flame or anything, but "my customers are lazy and don't want to
write portable code" isn't a very good reason to change the kernel.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
