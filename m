Date: Fri, 27 Aug 2004 19:16:42 +0400
From: Andrey Volkov <avolkov@varma-el.com>
Reply-To: Andrey Volkov <avolkov@varma-el.com>
Message-ID: <314790494.20040827191642@varma-el.com>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re[2]: [RFC] Remove G2_LE core decl from CLASSIC_PPC part of arch/ppc/kernel/cputable.c
In-Reply-To: <E832C827-F839-11D8-BF10-003065F9B7DC@embeddededge.com>
References: <927068331.20040827153454@varma-el.com>
 <E832C827-F839-11D8-BF10-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Dan,

Friday, August 27, 2004, 7:00:59 PM, you wrote:

>> Since G2_LE is NOT a "classic" core ( in particular - true
>> little-endian),

> How is it not a classic core?  It certainly isn't bookE, and it isn't
> 8xx.
> No one should care about little-endian anyway.  I'm voting for the
> first candidate that makes that illegal. :-)
Agree.

>> With that move we'll conserve some memory of kernel,

> How does this single change save anything but a few bytes of
> cpu table?

Maybe ~2K of rubbish for somebody "few" - for me not :) (don't forget
its embedded platform).

>> but need some explanations which PPCs based on
>> it, for modify Kconfig ( I know MPC52xx and MPC82xx based on it).

> What other kernel changes would you make based on
> this configuration?
Only Kconfig, nothing more.

--
Best regards,
 Andrey Volkov


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
