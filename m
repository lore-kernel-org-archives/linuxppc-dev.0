Date: Wed, 14 Nov 2001 11:24:21 +0100
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Subject: Re: ppc 405 floating point math emulation
To: Steven Mueller <diffusor@ugcs.caltech.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <3BF24655.F41E57EB@inn.ericsson.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <20011113155956.B7553@spew.ugcs.caltech.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Steven Mueller wrote:
>
> Hello,
>
> I'm interested in building a kernel with math emulation enabled for an
> embedded IBM ppc 405.  (It'd be nice to allow customers to run ppc
> apps on our cards without having to recompile them with soft float
> support.)

Yes it's nice. I'am running a full debian testing installation over nfsroot
on my cards.

> If anyone has already developed a solution for this, would you please
> consider posting the patch?  Thank you!

Just remove the printing or uppgrade to the devel tree it could use some more
testing.

--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
