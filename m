To: linuxppc-dev@lists.linuxppc.org
Subject: Re: altivec
References: <3785DD1F.B853E731@ssl.co.uk>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 09 Jul 1999 14:14:49 +0200
In-Reply-To: Sacha Varma's message of Fri, 09 Jul 1999 12:29:35 +0100
Message-ID: <8x673uf29y.fsf@s53.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sacha Varma <sacha@ssl.co.uk> writes:

> 
> Some questions about altivec & LinuxPPC:
> 
> 1. is there a free C compiler supporting altivec instructions for
>    linuxPPC?
>
Possibly. Someone from Cygnus (the maintainers of egcs/gcc) mentioned he'd
gotten source patches from Motorola that add AltiVec support to gcc.

Since MacOS X is a descendant of NeXTStep, and since NeXT always used gcc,
and since Apple is going to embrace AltiVec, one can reasonably expect that
at least Apple will use an AltiVec-aware variant of gcc. In an ideal world,
AltiVec support would make it into the main gcc tree.

> 2. would it be possible to trap altivec instructions on a non-altivec
>    processor and reroute them through code using generic instructions?

Possible - yes. Dead slow - absolutely. (Apple's simulator is strictly a
development tool, nothing more.)

>    (I believe this is how Apple's MacOS altivec simulator does it).

I don't know.

>    Presumably there is a bad instruction interrupt or something and
>    code in the kernel to trap these interrupts? (Excuse my naivety;
>    I'm more of a kernel user than hacker - for now!)
>
Yes, such exceptions are supported by PPC hardware.

> 3. has anyone written a C library to simulate the altivec instructions?
>
Apple's simulator is the only such program I know of.

  Holger

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
