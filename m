Message-ID: <3B7D8532.726AE883@mvista.com>
Date: Fri, 17 Aug 2001 16:57:22 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Boerner, Brian" <bmb@pirus.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Debugging Linux with PPCBoot and the BDI2000
References: <200108172021.PAA04309@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Boerner, Brian" wrote:
>
> I'm trying to debug my kernel using PPCBoot to load the kernel image via
> tftpboot and then stop it in start_kernel.

Ensure you are using the latest 2_4_devel kernel and Abatron firmware.
We have been developing something that will work better for Linux,
with less overhead and more flexibility on both sides.  It was required
due to 2.4.x page table changes, and I finally got the Linux part of
it checked in.

> 4. set a break at start_kernel (breaking on _start didn't work at all).

That's because _start isn't a virtual address as indicated in the
vmlinux
symbol table.  Set a hard breakpoint at zero if you must stop there.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
