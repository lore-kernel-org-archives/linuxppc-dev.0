Date: Wed, 11 Dec 2002 07:56:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: joakim.tjernlund@lumentis.se, acurtis@directvinternet.com,
	Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@au1.ibm.com>, Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
Message-ID: <20021211145658.GA19456@opus.bloom.county>
References: <IGEFJKJNHJDCBKALBJLLAELIFIAA.joakim.tjernlund@lumentis.se> <3DF70C55.3010709@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DF70C55.3010709@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 11, 2002 at 11:58:45AM +0200, Pantelis Antoniou wrote:

[snip]
> I think it's safe to assume that there is large amount of confussion at
> this subject.

Definatly.

> FWIW I dislike the use of iopa(), and I would be forced to duplicate the
> code of
> consistent_alloc() class of functions in my tree.

Why would you have to duplicate the consistent_alloc code?  It is not
tied to PCI, really.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
