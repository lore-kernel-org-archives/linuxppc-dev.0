Date: Mon, 23 Dec 2002 09:49:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org,
	Dan Malek <dan@embeddededge.com>
Subject: Re: New style dpalloc/hostalloc routines (diff).
Message-ID: <20021223164928.GF15397@opus.bloom.county>
References: <3E006C94.2090503@intracom.gr> <15874.23846.177956.192840@argo.ozlabs.ibm.com> <3E02E984.8090904@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E02E984.8090904@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 20, 2002 at 11:57:24AM +0200, Pantelis Antoniou wrote:

> Here is the updated patch in diff format as per your suggestions.

Looks good.  My only real issue is that this is a big change, so I would
rather see either (or both) of the following happen:
Make a patch vs 2.5.  This will require additional 8xx work to get
things going again.
Please hold on this until all of the otherwise stable 8xx work can get
out of the linuxppc_2_4_devel tree and into linuxppc_2_4 / Marcelo.

Also, Dan Malek, any comments on all of this?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
