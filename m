To: Tom Rini <trini@kernel.crashing.org>
Cc: 211668@bugs.debian.org, Michel D?nzer <michel@daenzer.net>,
	Cliff White <cliffw@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Bug#211668: 2.6.0-test5 "incorrect section attributes for .plt"
From: James Troup <james@nocrew.org>
Date: Mon, 22 Sep 2003 17:54:49 +0100
In-Reply-To: <20030922164511.GJ7443@ip68-0-152-218.tc.ph.cox.net> (Tom
 Rini's message of "Mon, 22 Sep 2003 09:45:11 -0700")
Message-ID: <87ad8wsqzq.fsf@nocrew.org>
References: <200309192258.h8JMwWs04059@mail.osdl.org>
	<1064060622.1347.45.camel@thor.holligenstrasse29.lan>
	<20030922164511.GJ7443@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> writes:

> But I don't think the .previous is needed anyhow, so if someone
> could verify that the following works (vs 2.6 current, but also a
> problem in 2.4)

It doesn't; but please see Alan's response[1].  I'm compiling a new
binutils with this patch ATM...

--
James

[1] http://sources.redhat.com/ml/binutils/2003-09/msg00381.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
