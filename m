Date: Sat, 22 Jan 2000 15:45:37 -0800 (PST)
From: Bill Studenmund <wrstuden@nas.nasa.gov>
To: Robert Neugebauer <rneugeba@undergrad.math.uwaterloo.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RS6000 to G4 assembly changes
In-Reply-To: <Pine.SOL.3.96.1000122013827.17059B-100000@fitch.math.uwaterloo.ca>
Message-ID: <Pine.SOL.3.96.1000122153947.26665B-100000@marcy.nas.nasa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 22 Jan 2000, Robert Neugebauer wrote:

> I am not trying to build a cross compiler, I am not trying to build GCC.
> My course at university uses its own compiler called uC++ (Micro C++).
>
> The compiler thus far only has the following targets that work:
[snip]
>         dmake ibm-rs6000
[snip]
>
> By my knowledge rs6000 is a RISC based architecture, thus I tried to build
> uC++ using the target ibm-rs6000. This resulted in an unrecognized opcode
> movl during compilation.
>
> If someone knows what the similar instruction on my G4 is, and any other
> problems I might/will encounter, I would appreciate it.

As others have said, there is no similar instruction.

I think the problem is that you haven't fully set your compile environment
up to generate ppc code. It sounds like you are using a ppc assembler but
that the c compiler is still emmiting x86 assembly code (which of course
the ppc assembler doesn't understand). Or some assembly language fragment
is getting included, and the wrong one is being pulled in.

Good luck!

Take care,

Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
