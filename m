Message-ID: <3B8408AD.729112C1@mvista.com>
Date: Wed, 22 Aug 2001 15:31:57 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Scott Anderson <scott_anderson@mvista.com>
Cc: Benjamin Herrenschmidt <benjamin.herrenschmidt@wanadoo.fr>,
	Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: status of linuxppc_2_4_devel for ppc405gp
References: <EFEAIMDCOOOHIEPHDNFJAEHDDBAA.stefan.roese@esd-electronics.com> <20010822134155.4105@mailhost.mipsys.com> <3B83D895.C5738613@mvista.com> <3B83E474.5B906F13@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Scott Anderson wrote:

> Stefan was talking about ppc4xx_gdb_init(), not kgdb stuff.  The problem
> I ran into in that function was that it turned off external debug
> support.

Ahhh....OK.  I kinda sorta remember a conversation with you about
this.

> ...  As a temporary workaround I ifdef'ed out the code that touched
> DBCR0 and DBCR1

>From Ben's comment it sounded like we are touching data structures
that don't exist anymore, or that I forgot to add as part of the
405 debugger support.  I'll check on it right now......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
