Message-ID: <3B8A89B2.814DFA6B@mvista.com>
Date: Mon, 27 Aug 2001 13:56:02 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: acmay@acmay.homeip.net
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: get_cycles/get_tbl on 405
References: <20010823185911.A3291@ecam.san.rr.com> <3B870EDE.711669EB@mvista.com> <20010825003547.J1165@sink.san.rr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


acmay@acmay.homeip.net wrote:

> They did. I just confused myself with too many kernel versions.

Cool.

> The __ftr_fixup doesn't seem to be used much in any of the other
> arch's.

It's a PowerPC thing that Ben recently added to make it easier
for us to manage the minor differences among the processor variations.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
