Date: Fri, 14 May 1999 08:32:49 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC-DR-1.0: Some questions
In-Reply-To: <373BE113.196A4C2B@wanadoo.fr>
Message-ID: <Pine.SUN.4.02.9905140830040.27935-100000@sea.ntplx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 14 May 1999, Martin Costabel wrote:

> 1. Is this list frozen, or will it be updated regularly?

There will be a 1.0.1, with some new things..

> 2. The following rpms were there in previous versions of pre-R5. They
> are running with DR-1.0. Are there reasons why are they missing from
> DR-1.0?
> 
> biff
> glint

Gone in RH6 (iirc)

> hfsutils

Either Jeff added that one, or it was a very old rpm.

> icewm (icewm-themes is there)

Hmm...  Not sure on that one.

> lesstif (lesstif-0.88.1-1b.src.rpm compiled without problems for me)
> llnlxdir
> xforms
> lyx

All relied on lesstif, and that's an extra.  (We tried to keep the ref
release as close to RH6 as possible.  Some things were needed
(mozilla/nspr) to get around other things.)

> proftpd 

I think Jeff added that one as well...

--
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
