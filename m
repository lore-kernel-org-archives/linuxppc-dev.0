Message-ID: <3AA7216F.15BE4872@mvista.com>
Date: Thu, 08 Mar 2001 01:06:39 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Magnus Damm <damm@opensource.se>
Cc: brendan.simon@bigpond.com,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
	Dan Malek <dmalek@jlc.net>
Subject: Re: linuxppc-embedded: mpc8260 bus frequency calculations
References: <3A9EFA26.8030805@bigpond.com> <3A9F4B2B.294B91CA@mvista.com> <3A9FAC18.2162E4AF@opensource.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Magnus Damm wrote:

> I think that would be nice for the mpc8xx boards too.

My plan is to just change them all.  It was originally this
way because it is the value given to me by the MBX boot rom
and was just propagated through all of the code.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
