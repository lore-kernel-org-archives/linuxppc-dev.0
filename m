To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Using the Altivec GNU patches
References: <p04310104b5b5105d93f2@[192.168.1.5]>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 08 Aug 2000 11:46:21 +0200
In-Reply-To: Justin Shore's message of Mon, 7 Aug 2000 20:31:02 -0500
Message-ID: <8x4s4w13wy.fsf@s63.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Justin Shore <listuser@vinnie.ksu.ksu.edu> writes:

>
> I'm curious, can I
> use the Altivec enchanced gcc (available at www.altivec.org) to
> optimize my compilations for those G4s?  I compile most of my own
> software; would it actually utilize the patched gcc or would it
> require special code changes to make it work?

You can use gcc-vec, but it won't automatically vectorize
code. Programs currently have to be rewritten to make use of
AltiVec. (I know of one commercial preprocessor application that does
some automatic vectorization at the source code level, but it's been
in beta stage for almost a year, I think.)

The high level programming model for AltiVec is quite nice and not too
hard to grasp; and gcc-vec does a respectable job generating good
machine code. If you're a programmer, you should take a look.

  Holger

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
