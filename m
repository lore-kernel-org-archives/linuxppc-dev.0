In-Reply-To: <927068331.20040827153454@varma-el.com>
References: <927068331.20040827153454@varma-el.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E832C827-F839-11D8-BF10-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [RFC] Remove G2_LE core decl from CLASSIC_PPC part of arch/ppc/kernel/cputable.c
Date: Fri, 27 Aug 2004 11:00:59 -0400
To: Andrey Volkov <avolkov@varma-el.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 27, 2004, at 7:34 AM, Andrey Volkov wrote:

> Since G2_LE is NOT a "classic" core ( in particular - true
> little-endian),

How is it not a classic core?  It certainly isn't bookE, and it isn't
8xx.
No one should care about little-endian anyway.  I'm voting for the
first candidate that makes that illegal. :-)

> With that move we'll conserve some memory of kernel,

How does this single change save anything but a few bytes of
cpu table?

> but need some explanations which PPCs based on
> it, for modify Kconfig ( I know MPC52xx and MPC82xx based on it).

What other kernel changes would you make based on
this configuration?


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
