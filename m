Message-ID: <3ADF440E.9D6232CA@mvista.com>
Date: Thu, 19 Apr 2001 16:01:18 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Steven Hein <ssh@sgi.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 RTC support
References: <3ADE0222.BF7F539C@sgi.com> <3ADE0501.321052F9@mvista.com> <3ADF1377.72242D3B@sgi.com> <3ADF3970.C015DB5D@mvista.com> <20010419124455.O13403@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> .....Just checking, Steven have you tried to
> enable the "PPC_RTC" driver and gotten this same incorrect behavior?

Yep, Tom's right as usual :-).  If we can get this driver
configured, it is just a generic wrapper to the ppc_md rtc functions
and should work.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
