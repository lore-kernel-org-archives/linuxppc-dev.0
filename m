Reply-To: <manu@stapf.org>
From: "Emmanuel STAPF" <manu@stapf.org>
To: "'Kaoru Fukui'" <k_fukui@highway.ne.jp>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Error when linking
Date: Sat, 20 Oct 2001 09:27:41 -0700
Message-ID: <001901c15984$23b05b80$f5732c0c@venice2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20011020162513.Postino-002980@smtp01.highway.ne.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I should add that they occur only when I have my 1000 files. A similar
project using those C function but smaller compiles without any problem.

Any idea why and what are the possible solutions?
Manu

> -----Original Message-----
> From: Kaoru Fukui [mailto:k_fukui@highway.ne.jp]
> Sent: Saturday, October 20, 2001 00:25
> To: manu@stapf.org
> Cc: linuxppc-dev@lists.linuxppc.org
> Subject: Re: Error when linking
>
>
> From: "Emmanuel STAPF" <manu@stapf.org>
> To: <linuxppc-dev@lists.linuxppc.org>
> Subject: Error when linking
> Date: Sat, 20 Oct 2001 00:03:44 -0700
>
> >
> > Hi,
> >
> > When compiling a big system composed of about 1000 c files,
> I get a lot
> > of errors such as reproduced below. Is there a solution to
> this problem?
> >
> > Thanks,
> > Manu
> >
> > /usr/lib/crt1.o: In function `_start':
> > /usr/lib/crt1.o(.text+0x20): relocation truncated to fit:
> R_PPC_REL24
> > __libc_start_main@@GLIBC_2.0
> >
> /usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegin.o: In
> > function `__do_global_dtors_aux':
> >
> /usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegi
> n.o(.text+
> > 0x94): relocation truncated to fit: R_PPC_PLTREL24
> > __deregister_frame_info@@GLIBC_2.0
> >
> /usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegin.o: In
> > function `frame_dummy':
> >
> /usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegi
> n.o(.text+
> > 0x12c): relocation truncated to fit: R_PPC_PLTREL24
> > __register_frame_info@@GLIBC_2.0
> > C1/Cobj1.o: In function `Facss3c':
> > C1/Cobj1.o(.text+0x1480c): relocation truncated to fit: R_PPC_REL24
> > __sigsetjmp@@GLIBC_2.0
>
> Glibc has those rabel.
> You can check with nm command
>
> Kaoru
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
