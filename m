Subject: Re: PATCH: requesting feedback on dead function optimisation
To: alan@linuxcare.com.au (Alan Modra)
Date: Mon, 10 Apr 2000 21:00:11 +1000 (EST)
Cc: greyham@research.canon.com.au (Graham Stoney),
        linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.rutgers.edu
In-Reply-To: <Pine.LNX.4.21.0004101956320.4828-100000@front.linuxcare.com.au> from "Alan Modra" at Apr 10, 2000 08:05:38 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000410110011.A273F3C960@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alan Modra writes:
> Graham, I suspect that if you create a custom linker script that tells ld
> where to put your .init.* sections, then you won't need the patch.

I'm not sure how that would help. The problem is that the order of the
individual .text.__FUNCTION__ sections is different to the order of the
combined entries in the __ex_table section. The .init.* stuff is something
else entirely.

Regards,
Graham

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
