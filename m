Message-ID: <3BD0EE54.80DC772A@mvista.com>
Date: Fri, 19 Oct 2001 23:24:04 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Mark Pilon <mpilon@midrivers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging ppc4xx VM w/ abatron
References: <3BD05C20.20E3396B@midrivers.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Pilon wrote:

> I'm trying to debug mvista's 2.4.2 kernel w/ the bdi2000 (v.1.05) and
> am having trouble once the mmu is turned on

We have unfortunately really screwed up the Abatron folks lately by
moving around bits in the Linux PTEs.  I've tried to coordinate this
the best I can, to ensure we understand what kernel version matches
the BDI2000 firmware version.  Unfortunately, I'm not the only one
making changes, so sometimes I miss things.  I apologize and continue
to work with Abatron to sort this out.  It's the fault of us that are
making kernel modifications....

Oh sorry, the short answer is you need to patiently ask Abatron to
get the version of firmware that matches the kernel you are debugging.
By the way, this is only a 4xx problem.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
