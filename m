Date: Sat, 22 Jan 2000 01:45:00 -0500 (EST)
From: Robert Neugebauer <rneugeba@undergrad.math.uwaterloo.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: RS6000 to G4 assembly changes
In-Reply-To: <200001220016.TAA19532@mal-ach.watson.ibm.com>
Message-ID: <Pine.SOL.3.96.1000122013827.17059B-100000@fitch.math.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am not trying to build a cross compiler, I am not trying to build GCC.
My course at university uses its own compiler called uC++ (Micro C++).

The compiler thus far only has the following targets that work:
        dmake sun-sparc-sunos
        dmake sun-sparc-svr4
        dmake sun-m68k-sunos
        dmake dec-ultrix-mips
        dmake dec-alpha
        dmake sgi-mips-r4000
        dmake sgi-mips-r3000
        dmake ibm-rs6000
        dmake hp-hppa
        dmake pc-i386-linux
        dmake gizmo

By my knowledge rs6000 is a RISC based architecture, thus I tried to build
uC++ using the target ibm-rs6000. This resulted in an unrecognized opcode
movl during compilation.

If someone knows what the similar instruction on my G4 is, and any other
problems I might/will encounter, I would appreciate it.

Thank You

Bob Neugebauer


On Fri, 21 Jan 2000, David Edelsohn wrote:

>
> 	Others probably can answer configuring GCC for Linux/PPC better
> than I, but it is looking for something like "powerpc-unknown-linux-gnu"
> as the target.
>
> 	rs6000 is NOT another ppc based architecture.
>
> 	If you are trying to build a linuxppc compiler hosted on x86
> Linux, then you need to build a cross-compiler.  Please read the cross-gcc
> FAQ to learn how to do this:
>
> http://www.objsw.com/CrossGCC/
>
> David
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
