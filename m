Message-ID: <3ED496F9.4090402@embeddededge.com>
Date: Wed, 28 May 2003 07:01:13 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jean-Denis Boyer <jdboyer@m5t.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PATCH: arch/ppc/8xx_io_fec.c
References: <AB5AF73EAF23304EA1B932174137CED7030368@m5tmail.m5t.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jean-Denis Boyer wrote:

> I tested on revisions B3 and D4, and did not see any problem.
> Anyway, fec_stop was already disabling the FEC,
> so if it was a problem, it would have broken there.

OK.  Just remember I mentioned this and be ready to fix it
when someone complains. :-)

> Do you mean for the mixed tabs/spaces? :-( Sorry for that one...
> I will fix and resubmit as soon as everyone agree on the changes.

Yes, and there is a Linux coding standards document that would be
nice if people followed:

	if (condition) {

not,
	if(condition){, or if( condition ){, or other weird variations

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
