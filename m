From: benh@kernel.crashing.org
To: <msokolov@ivan.Harhan.ORG>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Incoming to helium.harhan.org:/home/linuxppc/linuxppc_2_4_alt
Date: Mon, 8 Apr 2002 19:02:25 +0100
Message-Id: <20020408180225.10676@mailhost.mipsys.com>
In-Reply-To: <0204081705.AA21087@ivan.Harhan.ORG>
References: <0204081705.AA21087@ivan.Harhan.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>And I'm hoping that some day PReP will be part of CONFIG_GENERIC_PPC32. See
>BenH's response about putting CONFIG_ALL_PPC to rest and converting to
>CONFIG_GENERIC_PPC32.

Yes, I've started doing that on a _devel code base, then figured out that
I had to cleanup a few crap remaining in pmac/chrp/prep, and that it would
rather be in 2.5 (we can still backport later).
So I'll start again on 2.5 this week but only for pmac/prep/chrp, I'll let
the various board maintainers decide wether to move their board under the
CONFIG_GENERIC_PPC32 umbrella or not.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
