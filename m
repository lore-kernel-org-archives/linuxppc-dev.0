Message-ID: <3C20B81A.392AA3A5@mvista.com>
Date: Wed, 19 Dec 2001 09:54:02 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: srinivas pulipati <srinivasp@multitech.co.in>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: glibc-2.2.4 cross compilation for mpc860
References: <3C203405.4254CA31@multitech.co.in>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


srinivas pulipati wrote:
>
> hi all.
>
> i am trying to compile glibc-2.2.4 for mpc 860.
> should i apply any patche or can i compile straight away.
> pls give suggestion.
>
> thanks
> srinivas
>

You must apply some no-floating point patches unless you enable floating
point emulation in the kernel.

To get a copy of patches that _MIGHT_ work, I suggest you look at
ftp.mvista.com and get the Journeyman glibc.  (Based on gcc 2.95.3)

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
