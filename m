Date: Sun, 19 Jan 2003 17:31:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: New style dpalloc/hostalloc routines (diff).
Message-ID: <20030120003137.GF888@opus.bloom.county>
References: <3E006C94.2090503@intracom.gr> <15874.23846.177956.192840@argo.ozlabs.ibm.com> <3E02E984.8090904@intracom.gr> <20021223164928.GF15397@opus.bloom.county> <3E076D09.8020807@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E076D09.8020807@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Dec 23, 2002 at 03:07:37PM -0500, Dan Malek wrote:
> Tom Rini wrote:
>
> >Also, Dan Malek, any comments on all of this?
>
> I've had some life distractions for the past couple of weeks.
> I'll have some time to look at this over the next few days.

So, have you had time to look at all of this yet?

> When are we going to stop using 2.4 as our development tree?
> Things like this should first be developed and proven in the 2.5
> tree then moved into 2.4 after we agree it's necessary.

Mainly because no one with the indepth knowledge of 8xx (*hint*hint* :))
has gone and fixed the very low level issues on 8xx which need to be
fixed, such as some MM thing or another from 2.5.5/2.5.10 timeframe and
the exception handling stuff ne3ds a look at, at a minimum based on what
Paul has done for 'classic' and what Paul and/or David and others have
done for 40x.  At which point the more trivial things like fixing up
drivers can happen. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
