Date: Thu, 2 Jan 2003 11:21:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel patch: 8xx FEC extensions
Message-ID: <20030102182147.GB853@opus.bloom.county>
References: <20030102174010.D97DFC6139@atlas.denx.de> <3E1480E6.4010802@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E1480E6.4010802@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jan 02, 2003 at 01:11:50PM -0500, Dan Malek wrote:
> Wolfgang Denk wrote:
>
>
> >I don't see where a "volatile" gets dropped in any really significant
> >way.
>
> No, it doesn't.  The function logically does exactly the same thing,
> so I don't understand why these changes were necessary. :-)
>
> The original code simply accessed the 'phy_status' in the data structure
> as a volatile object.  The modification from Wolfgang makes any data
> structure access volatile, and then updates the 'phy_status' only once
> at the end.
>
> If it makes something work better for Wolfgang, that's fine :-).  To me,
> it seems to be covering up some other timing problem since the only
> thing different is how many times a particular memory location is accessed.

Would the patch, along with a comment about this potentially covering up
HW timing issues (since this seems to have 'fixed' a problem on a
certain HW config) be OK with everyone?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
