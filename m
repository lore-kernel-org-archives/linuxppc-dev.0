Message-ID: <39EDC4A7.D759048A@mvista.com>
Date: Wed, 18 Oct 2000 11:41:27 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
CC: paulus@linuxcare.com.au, Tilmann Bitterberg <tibit-ibm@bitterberg.de>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: HIGHMEM now working
References: <200010180727.JAA13865@denx.local.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wolfgang Denk wrote:

> What do you think about including IMMR in the board  info  structure,

That is a good idea.  I started doing that on the 8260s because you
can't find the IMMR in any special register.  Next, I am going to change
all of the ((immr_t *)IMMR)-> to use a global immr variable.  Then I
am going to remove the IMMR TLB entry, finish the support for large,
wired TLB entries, and have this initialized as part of the m8xx set up.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
