Message-ID: <39B2EBD9.2DD2FF23@ctam.com.au>
Date: Mon, 04 Sep 2000 10:24:57 +1000
From: Brendan J Simon <brendan.simon@ctam.com.au>
Reply-To: brendan.simon@ctam.com.au
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where is the embedded-ppc ftp site ???
References: <39AF5AD7.B23D0FA3@ctam.com.au> <39AFCB13.D6E49F5C@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > What about support for the 860 ?  Is the 860 code integrated to the main
> > kernel ?
>
> The 8xx and 8260 (among lots of others) are a standard part of the
> sources at kernel.org.
>
> > Is there a CVS repository for Linux kernels with embedded procoessor
> > support ?
>
> The bleeding edge stuff is on fsmlabs.com, in BitKeeper.

Does this include support for *all* the embedded boards ?
It's generally easier to modify a board that is similar to ours, then try to
do the whole thing from scratch (and usually in a different way).  I'll check
out fsmlabs.com.  Thanks.

Last time I looked at this stuff (linux-2.2.13 I think) there was only support
for the MBX board in the official linux kernels.
The other embedded boards (BSEIP, RPX, etc) were maintained elsewhere.  I'm
not even sure if they were available via CVS but they were via tar.gz files on
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded

Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
