Message-ID: <3A7B37E9.D20210A2@mvista.com>
Date: Fri, 02 Feb 2001 14:42:49 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: "Curry, Diane" <dcurry@infiniswitch.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdb on IBM Walnut board panics the kernel
References: <FF6CF34C346E724596A2FB5CAAB2C49707F8F2@voyager.ops.infiniswitch.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Curry, Diane" wrote:
>
> I'm running Monta Vista's Hard Hat Linux (11/26/200 2.4.0-test2) on an
> IBM 405GP walnut rev D board. On an x86 PC running Red Hat Linux 7.0,
> using MV's CDK, I built a small program using ppc_4xx-gcc with the -g
> switch.
> The executable is in /tmp of the root filesystem
> (/opt/hardhat/devkit/ppc/4xx/target)
> that is exported for the target linux to nfs mount. The program, when
> run by itself, runs fine.  However, when running gdb on the program, the
> kernel panics (explicitly setting
> breakpoints produces the same result).
> Has anyone observed similar behavior or recognize the possible cause?
> Any suggestions would be greatly appreciated.
>
> Diane Curry
> Infiniswitch Corp.
> dcurry@infiniswitch.com

Yes, this is a known problem.  (It's described in the README file in the
top directory of the CDK.)  The problem is that ptrace is not yet
implemented for the 4xx processors.  I have ptrace working in an old
version of the kernel, but haven't yet moved it forward to a current
kernel and cleaned up the implementation.  This is a very high priority
item for completion.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
