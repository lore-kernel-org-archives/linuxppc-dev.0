Date: Fri, 21 Jan 2000 17:53:50 -0500 (EST)
From: Robert Neugebauer <rneugeba@undergrad.math.uwaterloo.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: RS6000 to G4 assembly changes
In-Reply-To: <200001211908.OAA27094@mal-ach.watson.ibm.com>
Message-ID: <Pine.SOL.3.96.1000121174930.10776A-100000@bacon.math.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am sorry my initial post was not clear. There is compiler that is used
for one of my courses at university. The compiler itself only has build
rules for i386 linux, rs6000 aix, and some other unixes. Anyway I am
trying to build this compiler for my linuxppc machine. Since rs6000 is
another ppc based architecture, I tried building using that target, and
that is where I got the movl error. Apparently movl is a valid instruction
for the rs6000. I am curious what I need to change it too.

I hope this clarifies things.

Bob

On Fri, 21 Jan 2000, David Edelsohn wrote:

>
> 	"movl" is an x86 mnemonic.  "rs6000" is the same as "powerpc" as
> far as GCC configurations are concerned, for the most part.  RISC
> arcihtecture is a generic computer architecture term that does not provide
> any assistance in compatibility.  Other than that, I cannot understand
> what you are trying to accomplish.
>
> 	Are you trying to build a cross compiler?  From linuxppc to x86
> linux?  From x86 linux to linuxppc?  From either of those to RS/6000 AIX?
> It does not sound like you have the cross-toolchain properly configured
> and/or you are not following the proper sequence to build a
> cross-toolchain and/or you have some old configuration/build files laying
> around when trying to build a new toolchain.
>
> David
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
