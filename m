Date: Wed, 29 May 2002 15:45:51 -0700
From: Matt Porter <porter@cox.net>
To: Roland Dreier <roland@topspin.com>
Cc: Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ebony crash fix & 440GP cleanup step one
Message-ID: <20020529154551.C3960@home.com>
References: <20020524134731.A21503@home.com> <523cwcudy1.fsf_-_@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <523cwcudy1.fsf_-_@topspin.com>; from roland@topspin.com on Tue, May 28, 2002 at 03:04:22PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 28, 2002 at 03:04:22PM -0700, Roland Dreier wrote:
> This email includes two patches.  First, a very small change to
> ocp.h.  Somewhere in the recent cleanup, paddr got changed from a
> phys_addr_t to a void *; this doesn't work on 440GP because we have
> 36-bit physical addresses.  (You get a machine check when the kernel
> tries to access the ZMII)
>
> Second, the beginning of moving generic IBM 440GP stuff out of
> ebony.c/ebony.h and into platforms/ibm440gp.h.  I tested this on my
> Ebony and it boots and runs fine.  I didn't go too far because I want
> to make sure everyone feels what I'm doing is the right way to go.
> Please let me know what you think.

Looks great, pushed.  There's still more work to do in the includes
but it's a good start.  I'm moving the PCIX initialization to a
common library, so don't overlap there if you wander out of
moving headers around.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
