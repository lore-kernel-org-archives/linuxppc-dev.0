Message-ID: <3E7F7BB8.7080106@embeddededge.com>
Date: Mon, 24 Mar 2003 16:42:16 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc.  Org" <linuxppc-embedded@lists.linuxppc.org>,
	strauman@SLAC.Stanford.EDU
Subject: Re: dcbz works on 862 everywhere!
References: <IGEFJKJNHJDCBKALBJLLEEGBFLAA.joakim.tjernlund@lumentis.se> <20030324201543.GB14264@ip68-0-152-218.tc.ph.cox.net> <003501c2f248$06ddc700$020120b0@jockeXP>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> I will removed the Guarded flag though since I don't see why it's there. Speak up
> now if you want to have it left.

Everything is there for a reason, including setting the guarded flag if
the PTE indicates this should be done.  Since it doesn't seem to be clear
from messages I've sent in the past, the guarded flag is used to ensure
the proper order of operation on I/O spaces.  Any ioremap will request
this feature.

Thanks.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
