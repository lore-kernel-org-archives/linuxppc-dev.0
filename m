Date: Tue, 27 Nov 01 12:58:26 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111272058.AA25047@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Please make K2 Linux bootable without PeeMON again
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> Right.  I think I confused you somewhere along the line.  I want the
> kernel to be told the bi_recs are <someplace>.  I just want to get what
> people think would be a good rule-of-thumb <someplace>.  I take it you
> belive 8mb and change is a good rule-of-thumb location, yes?

Yes.

Now the question is how to pass the pointer to bi_recs to the kernel. I propose
a physical address in R3, as this is the most obvious way and there is
precedent for it already (I even seem to recall that someone else other than me
is already doing this).

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
