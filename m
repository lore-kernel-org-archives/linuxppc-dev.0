Message-ID: <3E9338A8.3090601@embeddededge.com>
Date: Tue, 08 Apr 2003 17:01:28 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Till Straumann <strauman@slac.stanford.edu>
Cc: joakim.tjernlund@lumentis.se,
	Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx DCBZ (&friends) hw bug. Tests, analysis + conclusions.
References: <IGEFJKJNHJDCBKALBJLLMENAFLAA.joakim.tjernlund@lumentis.se> <3E92F80C.1020409@slac.stanford.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Till Straumann wrote:

> Why not tag MD_EPN with an unused CASID?

There isn't such a thing.  The ASIDs are used for MMU optimizations.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
