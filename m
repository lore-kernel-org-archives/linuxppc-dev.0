Subject: Re: crash loadin bash after booting linux on a MPC860ADS
To: t.shantha.laxmi@exgate.tek.com
Date: Wed, 17 May 2000 09:55:53 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
In-Reply-To: <21F9768AF088D211BF1C0008C71E5786EEFF62@ap-bang-m02.india.tek.com> from "t.shantha.laxmi@exgate.tek.com" at May 16, 2000 05:49:42 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000516235553.C15D13C962@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


t.shantha.laxmi@exgate.tek.com writes:
> page fault in interrupt handler, addr=c0002578
> NIP: C005EE64 XER: 0000B86D LR: C005EE44 REGS: c00c99c0 TRAP: 0300
...
> Kernel panic: kernel access of bad area pc c005ee64 lr c005ee44 address
> C0002578

Looks like one of your interrupt handlers is causing a page fault. Disassemble
your vmlinux with objdump --disassemble, and find the instruction at C005EE64.
It's the one causing the fault.

By the way, do any other list members know of any references on the 'net that
give some PowerPC-specific tips to decoding oops messages?  If I can find
something more applicable than Documentation/oops-tracing.txt, I'd like to
include a link to it in the HOWTO.

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
