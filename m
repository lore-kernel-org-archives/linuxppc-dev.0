Subject: Re: Good embedded board to start with
To: mak@icon.fi (Mika Kuoppala)
Date: Thu, 9 Dec 1999 11:09:36 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.9912082231580.21860-100000@atom.icon.fi> from "Mika Kuoppala" at Dec 8, 99 11:17:57 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19991209000936.55B7D118BA@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mika Kuoppala writes:
> What would be a good board to purchase just to 
> get newbie's feet wet in this embedded ppc world ?

We're using a couple of Embedded Planet CLLF boards for this kind of
evaluation/development work. They give you a nice small complete CPU subsystem
which you can plug a custom daughter card into if you've got special hardware.
No need to re-invent the wheel. The Bright Star IP Engine has an onboard FPGA
and was our second choice, but it doesn't support the 860T so we went with the
CLLF. Either one would meet the requirements you listed. There's a learning
curve but it's not steep if you already know Linux. For the most part this
stuff "just works" and the people on the mailing list are incredibly helpful.

> If things get much easier by buying some ppc based development
> machine to compile things for the board (some mac or imac or other ppc
> workstation), it is an option too.

If all other things are equal, a PPC based development machine will save you
cross-compiling and let you run the same binaries on the board, lessening your
development pain. For various reasons we've chosen to cross-develop from
Linux x86, and it's certainly still doable either way.

> Am i totally in too deep waters with this ?

No way; go for it!

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
