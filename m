Date: Tue, 17 Jul 2001 10:14:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ethan Blanton <eblanton@cs.ohiou.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Clock drift on an iBook2
Message-ID: <20010717101420.B2878@opus.bloom.county>
References: <20010717102730.B22214@localhost.localdomain> <20010717165032.5490@smtp.adsl.oleane.com> <20010717130425.G22214@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010717130425.G22214@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 17, 2001 at 01:04:25PM -0400, Ethan Blanton wrote:
> Benjamin Herrenschmidt spake unto us the following wisdom:
> > >I have a new iBook2 and I'm having *severe* clock drift problems -- on
> > >the order of several seconds gained per minute.  I'd like to get this
> > >taken care of, and it seems to be a linux problem as OSX appears to
> > >have a stable clock.
> >
> > Are you using MOL or do you experience this with nothing special running ?
>
> Nothing special...   I tried using ntpd to fix the problem, but it
> didn't seem to be able to set the system time and I'm not sure why.

Does your kernel have CONFIG_PPC_RTC enabled? (_not_ CONFIG_RTC).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
