Message-Id: <200205040154.VAA28992@makai.watson.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Joern Nettingsmeier <nettings@folkwang-hochschule.de>,
	=?iso-8859-1?Q?K=E1ri=20Dav=ED=F0sson?= <kd@flaga.is>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Powerbook 
In-Reply-To: Message from Paul Mackerras <paulus@samba.org>
   of "Sat, 04 May 2002 08:56:01 +1000." <15571.5505.916224.351719@argo.ozlabs.ibm.com>
Date: Fri, 03 May 2002 21:54:52 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Paul Mackerras writes:

Paul> No, if you're in for quick compilation, compile a kernel for i386
Paul> rather than a kernel for ppc, for some reason gcc is quicker at
Paul> producing x86 output than ppc output, i.e. the x86 compilation
Paul> involves less computation.

	PowerPC GCC is multi-arched by default for both 32-bit and 64-bit,
so many values internally are computed as 64-bit "long long" quantities.
i386 does not default to x86_64, so it uses word-sized ints.

	PowerPC GCC has many more registers to allocate and more
restricted operands for instructions.

	GCC on RISC (e.g., PowerPC) runs the scheduler at two different
phases of the compilation.  GCC on CISC (e.g., i386) runs the scheduler
only once.

	Those are some of the differences I can think of off the top of my
head.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
