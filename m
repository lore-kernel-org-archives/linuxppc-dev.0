Message-ID: <3991B54B.E5B83449@embeddededge.com>
Date: Wed, 09 Aug 2000 15:47:23 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: PaulFagerburg@RenaissanceNT.com
CC: "'linuxppc'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: RPX CL-LF crashing on MVista Hardhat Linux
References: <000f01c00235$e16aa9c0$5301a8c0@RenaissanceNT.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Fagerburg wrote:

> Thanks to the many people who responded to help me with the earlier
> problems - it turned out that the default kernel in hardhat linux expects
> the ethernet to be on SCC2,

Well, more specifically, the LSP you are trying to use is for the
RPX-Lite, which isn't a CLLF.  There is a Linux Support Package (LSP)
for the CLLF which will work on that board.

> However, I am now experiencing a new problem: random crashes.

I suspect you have a Revision B (like B2 or B3) silicon, which requires
the "CPU6" silicon errata software fixes.  Just enable those as part of
the configuration process.  It adds some overhead and code that is
nice to remove, but if you need it......



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
