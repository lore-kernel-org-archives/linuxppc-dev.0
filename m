Date: Sun, 10 Jan 1999 16:21:58 -0600 (CST)
From: Tom Rini <trini@globe.linuxppc.org>
To: Olaph Swensen <olaph@takilma.nurk.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: compiling ssh / R5 install
In-Reply-To: <Pine.LNX.4.04.9901052025040.2383-100000@lsd.takilma.or.us>
Message-ID: <Pine.LNX.3.96.990110161916.15302A-100000@globe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 5 Jan 1999, Olaph Swensen wrote:

> login.c:437: structure has no member named `ut_syslen'

#if out this line or remove

> login.c:441: structure has no member named `e_termination'
> login.c:442: structure has no member named `e_exit'

__e_*

> login.c:454: `WTMPX_FILE' undeclared (first use in this function)
> login.c:454: (Each undeclared identifier is reported only once
> login.c:454: for each function it appears in.)

Needs a __USE_GNU or something along those lines, IIRC.  At least these
are glibc 2.1 changes/probelsm for everybody. :)

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
