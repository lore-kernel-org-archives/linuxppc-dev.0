Message-ID: <3ED3BDA0.3030208@embeddededge.com>
Date: Tue, 27 May 2003 15:33:52 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Jean-Denis Boyer <jdboyer@m5t.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PATCH: arch/ppc/8xx_io_fec.c
References: <AB5AF73EAF23304EA1B932174137CED702FB6D@m5tmail.m5t.com> <20030527165824.GG3453@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> Dan, do you see any problems with this?

Yes.  There are silicon revisions that require the FEC to
be enabled for the MDIO to operate.  I don't remember if it was
listed in errata or in some of the early supplements.  This code
change may work in this particular case, but I know it's required
for some parts.  I have not looked at the detail of the patch
and the code it moves to see if this is done elsewhere.

The code formatting looks like crap, so that needs to be fixed.

It would be nice to hear from other people that have recently made
changes for specific board/PHY combinations to see if this patch
affects them.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
