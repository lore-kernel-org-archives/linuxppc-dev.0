Message-ID: <3AE9C98A.2AE312EA@mvista.com>
Date: Fri, 27 Apr 2001 19:33:30 +0000
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: John Cagle <jcagle@kernel.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel driver debugging
References: <20010427001350.760232792B@denx.denx.de> <3AE8BFD6.54EE57C3@ixiacom.com> <20010426232851.A3674@kernel.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John Cagle wrote:
>
> What about IBM's tools: RiscWatch and RiscTrace?  Does anyone have
> any experience with these, and how do they differ from the BDI2000?

RiscWatch runs on Wintel.  It doesn't come anywhere near integrating
well with Linux.  I also encountered problems because the RiscWatch
doesn't give you as much control over the initialization it does to
the processor.  The bottom line for me is that it is *way* nicer to
use ddd on top of gdb debugging a kernel built with -ggdb using the
Abatron.  RiscTrace should give you the advantage of being able to
see the past execution of your code, but in practice, I never found
it very useful.

    Scott

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
