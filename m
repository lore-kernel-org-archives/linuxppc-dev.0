Message-ID: <3E7F9017.2000900@embeddededge.com>
Date: Mon, 24 Mar 2003 18:09:11 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc.  Org" <linuxppc-embedded@lists.linuxppc.org>,
	strauman@SLAC.Stanford.EDU
Subject: Re: dcbz works on 862 everywhere!
References: <IGEFJKJNHJDCBKALBJLLEEGBFLAA.joakim.tjernlund@lumentis.se> <20030324201543.GB14264@ip68-0-152-218.tc.ph.cox.net> <006601c2f256$e6ff5e80$020120b0@jockeXP>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> OK, here it goes.

No, this isn't correct......


> + /* The 20 msb of MD_EPN and DAR must be the same when rfi is
> +  * executed. The dcxx instructions don't set DAR when they
> +  * cause a DTLB Miss so copy them from MD_EPN.

No, don't be screwing around with these registers.



> -#ifdef CONFIG_8xx
> +#ifdef CONFIG_8xx_CPU6

What is this all about?  The CPU6 errata is a clearly defined
problem on well known silicon revisions.  Don't be using it where
it isn't intended.

Please try again..........thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
