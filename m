Message-ID: <3A59FA56.688369B4@mvista.com>
Date: Mon, 08 Jan 2001 12:35:18 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Mike Beede <mbeede@cisco.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Possible VM fix(s) for 2.4 PPC port
References: <3A59F666.E5376DE6@cisco.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mike Beede wrote:

> .....  If this isn't the place to
> send these, can someone let me know?

This will work.

> The second problem is that if you vmalloc memory requiring a new entry
> in the
> kernel pgd,

Crap, not again.....This was broken/fixed/broken/fixed during 2.3
and I thought it was finally correct.  It's really obvious on the
MPC8xx processors and I haven't seen it for a while.  I'll look
into it, as it used to be hidden away in macros or other generic
functions.  I thought the 6xx/7xx should have worked (unless we
have made some BAT mapping change recently.....)


Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
