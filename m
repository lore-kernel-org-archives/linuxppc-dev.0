Message-ID: <3A628C9B.489E401A@mvista.com>
Date: Mon, 15 Jan 2001 00:37:31 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Timothy Ritchey <tritchey@vacuumgenesis.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kswapd Oops
References: <3A625423.E0F6C9AC@vacuumgenesis.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Timothy Ritchey wrote:
>
> I am running the the linuxppc_2_4 snapshot from 01/13/01, booting using
> ppcboot on a custom 860T-based board with 64 MB of dram. I am getting
> periodic Oops like:

What other versions of the kernel have you used that seem to work OK?

> the call backtrace indicates this is occuring during kswapd. I am trying
> to isolate the problem to figure out what needs fixing. Is this a
> potential MMU problem, or could it be a problem with the swap setup.

What is the silicon revision of the chip?

What were you doing at the time you received this error?


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
