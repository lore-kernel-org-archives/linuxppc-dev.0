Message-ID: <392C87C2.3A2EEA9B@embeddededge.com>
Date: Wed, 24 May 2000 21:54:10 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Jason Wohlgemuth <jsw-embedded@mindspring.com>
CC: Dan Malek <dan@netx4.com>, mporter@mvista.com, tjroberts@lucent.com,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: QUERY: Embedded PowerPC Linux?
References: <NCBBKJKKGDLPHKDPAFFMAEMCCEAA.jsw-embedded@mindspring.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jason Wohlgemuth wrote:
>
> Dan,
>
> I actually modified head.S, not to get linux running, but to reboot the
> system.  In our case, the gpio pin tied to the HRESET line actually reset
> several boards, which would be a bad thing in some cases.  So I modified the
> m8xx_gorom (I think),

Sure, pick on the one thing I constantly mess up across the various
releases and patches :-).  I don't even know why this function is
in this file, as it needs to be different for almost every board.
It is only a couple of lines of code, so have fun.

I am more concerned about messing up the kernel initialization
code.  There are many assumptions (valid) that are made here about
the rest of the kernel structure.  Similar to having unique processor
and board initialization somewhere, this is unique to the Linux
kernel.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
