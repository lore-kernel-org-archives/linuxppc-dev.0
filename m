Subject: Re: PATCH: requesting feedback on dead function optimisation
To: alan@linuxcare.com.au (Alan Modra)
Date: Tue, 11 Apr 2000 15:41:31 +1000 (EST)
Cc: greyham@research.canon.com.au (Graham Stoney),
        linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.rutgers.edu
In-Reply-To: <Pine.LNX.4.21.0004102155180.4828-100000@front.linuxcare.com.au> from "Alan Modra" at Apr 10, 2000 10:01:13 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000411054131.3FFC83C96A@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alan Modra writes:
> Sorry, I was forgetting which sections were getting reversed.  Create a
> linker script with an entry like
>   *(.text.*)
> in section .text then.

Minor problem: this means that the final link stage sees a single .text
section, so --gc-sections has no effect.

I still think using ar for the intermediate stages makes more sense, so I'll
focus on working around whatever problems were convincing people that ld -r
worked better.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
