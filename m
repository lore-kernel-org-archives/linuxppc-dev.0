From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15337.62287.965562.545296@cargo.ozlabs.ibm.com>
Date: Thu, 8 Nov 2001 13:51:59 +1100 (EST)
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: The Plan
In-Reply-To: <3BE9D4B8.6A2E8603@mvista.com>
References: <15337.7275.266062.777161@cargo.ozlabs.ibm.com>
	<3BE9D4B8.6A2E8603@mvista.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark A. Greer writes:

> I would move harrier.c and pplus_common.c to the "kernel" dir since they
> are both bridge related files (kinda like the mpc10x_common.c file).

I wondered about pplus_common.c, actually.  Are pplus_common.c and
harrier.c likely to be used by more than one or two platforms in the
future?  If we leave them in kernel then we need to move the
corresponding header files to include/asm-ppc.

BTW, I would love to find a way to move all the platform-specific
files (mvme5100.h, for instance) from include/asm-ppc to
arch/ppc/platforms too.  The obstacle at the moment is the serial
stuff.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
