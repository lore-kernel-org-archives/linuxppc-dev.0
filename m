MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Powerbook
Date: Sun, 5 May 2002 14:16:59 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31937F1E@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Paul Mackerras" <paulus@samba.org>,
	"Joern Nettingsmeier" <nettings@folkwang-hochschule.de>
Cc: <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> -----Original Message-----
> From: Paul Mackerras [mailto:paulus@samba.org]
> Sent: 3. maí 2002 22:56
> To: Joern Nettingsmeier
> Cc: Kári Davíðsson; linuxppc-dev@lists.linuxppc.org
> Subject: Re: Powerbook
>
>
> Joern Nettingsmeier writes:
>
> > <asbestos mode="full body protection">
> > if you're in for quick compilation, get an intel machine.
> > </asbestos>
>
> No, if you're in for quick compilation, compile a kernel for i386
> rather than a kernel for ppc, for some reason gcc is quicker at
> producing x86 output than ppc output, i.e. the x86 compilation
> involves less computation.

It has something to do with RISC versus CISC architectures, i.e. RISC
offloads much of scheduling (?) to the compiler....
My old trusted Alpha had the same "problem" when I was using it for
development.
It is also very visible if you use cross compiler on an PIII to generate
ppc code (like I am doing now). The same code compiles significantly
slower
if cross compiled rather than natively compiled for the PIII.

K.D.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
