Date: Mon, 29 Apr 2002 21:04:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: leeyang <leeyang77@hotmail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [trini@kernel.crashing.org: [PATCH] Allow openpic_init to set all combos of polarity and sense]
Message-ID: <20020430040445.GC21482@opus.bloom.county>
References: <20020430003434.GA21482@opus.bloom.county> <OE120wZDyDG742l3ew100002f33@hotmail.com> <20020430033341.GB21482@opus.bloom.county> <3CCE1653.7050709@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CCE1653.7050709@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Apr 29, 2002 at 11:58:11PM -0400, Dan Malek wrote:
> Tom Rini wrote:
>
> >Note, Sandpoint is probably currently broken in linuxppc_2_4_devel since
> >I believe it relied on overloading NumInitSenses .....
>
> I thought Paulus finally took this hack and implemented it in a way
> that made him happy. :-)  Was I mistaken?  Several of us checked this
> in over and over, it really shouldn't be removed unless there is
> something better.

Right.  The hack is gone, and now we have openpic_set_sources().  If a
board relied on the hack, it's quite probably non-functional right now
(the lopec didn't get _anywhere_, but that might have been due to always
having a bogus polarity & whatnot).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
