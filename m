Reply-To: <manu@stapf.org>
From: "Emmanuel STAPF" <manu@stapf.org>
To: "'Brad Boyer'" <flar@pants.nu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Error when linking
Date: Thu, 25 Oct 2001 08:55:27 -0700
Message-ID: <000401c15d6d$77730690$f5732c0c@venice2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <20011021042633.BE4EA2B54A@marcus.pants.nu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I tried to build my objects file as shared library just to see if it
would have worked. But with no success, my app core dumps when I try to
launch it. But in my case doing shared library is not an option since I
would have about 100 shared libraries for my app so it becomes a
nightmare to manage.

Does anyone know if there is a linker workaround or if there is a way to
either fix gcc or ld to make sure they can handle large objects with no
modification of the code. I don't see why on LinuxPPC one would have to
modify code that runs on other Linux et UNIX platforms.

Thanks,
Manu

> -----Original Message-----
> From: owner-linuxppc-dev@lists.linuxppc.org
> [mailto:owner-linuxppc-dev@lists.linuxppc.org] On Behalf Of Brad Boyer
> Sent: Saturday, October 20, 2001 21:27
> To: manu@stapf.org
> Cc: linuxppc-dev@lists.linuxppc.org
> Subject: Re: Error when linking
>
>
>
> Take a look at this thread in the archives:
>
> http://lists.linuxppc.org/linuxppc-user/199907/msg01059.html
>
> Similar problem (90M executable), and the solution seems to
> have been to use shared libraries.
>
> Emmanuel STAPF wrote:
> >
> >
> > Indeed my problem is supposed to be around 50MB in size and as you
> > guessed I can't make it smaller.
> >
> > I looked at the mailing list archive but I could not find what I
> > should use to make `ld' link my object files. So if anyone as the
> > solution do not hesitate to share it.
> >
> > Thanks,
> > Manu
> >
>
>
>

> -----Original Message-----
> From: owner-linuxppc-dev@lists.linuxppc.org
> [mailto:owner-linuxppc-dev@lists.linuxppc.org] On Behalf Of
> Emmanuel STAPF
> Sent: Saturday, October 20, 2001 00:04
> To: linuxppc-dev@lists.linuxppc.org
> Subject: Error when linking
>
>
>
> Hi,
>
> When compiling a big system composed of about 1000 c files, I
> get a lot of errors such as reproduced below. Is there a
> solution to this problem?
>
> Thanks,
> Manu
>
> /usr/lib/crt1.o: In function `_start':
> /usr/lib/crt1.o(.text+0x20): relocation truncated to fit:
> R_PPC_REL24 __libc_start_main@@GLIBC_2.0
> /usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegi
> n.o: In function `__do_global_dtors_aux':
> /usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegi
> n.o(.text+
> 0x94): relocation truncated to fit: R_PPC_PLTREL24
> __deregister_frame_info@@GLIBC_2.0
> /usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegi
> n.o: In function `frame_dummy':
> /usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegi
> n.o(.text+
> 0x12c): relocation truncated to fit: R_PPC_PLTREL24
> __register_frame_info@@GLIBC_2.0
> C1/Cobj1.o: In function `Facss3c':
> C1/Cobj1.o(.text+0x1480c): relocation truncated to fit:
> R_PPC_REL24 __sigsetjmp@@GLIBC_2.0
> C2/Cobj2.o: In function `Fan1eqv':
> C2/Cobj2.o(.text+0x23b78): relocation truncated to fit:
> R_PPC_REL24 __sigsetjmp@@GLIBC_2.0
> C2/Cobj2.o: In function `Fan3cjq':
> C2/Cobj2.o(.text+0x24968): relocation truncated to fit:
> R_PPC_REL24 __sigsetjmp@@GLIBC_2.0
> C2/Cobj2.o: In function `Fan3_hc':
> C2/Cobj2.o(.text+0x2519c): relocation truncated to fit:
> R_PPC_REL24 __sigsetjmp@@GLIBC_2.0
> C5/Cobj5.o: In function `Fbbi2tl':
> C5/Cobj5.o(.text+0x10638): relocation truncated to fit:
> R_PPC_REL24 calloc@@GLIBC_2.0
> C5/Cobj5.o: In function `Fbbow77':
> C5/Cobj5.o(.text+0x1074c): relocation truncated to fit:
> R_PPC_REL24 calloc@@GLIBC_2.0
> C5/Cobj5.o: In function `Fbb883r':
> C5/Cobj5.o(.text+0x10920): relocation truncated to fit:
> R_PPC_REL24 calloc@@GLIBC_2.0
> C5/Cobj5.o: In function `Fbcj80c':
> C5/Cobj5.o(.text+0x10a74): relocation truncated to fit:
> R_PPC_REL24 calloc@@GLIBC_2.0
> C5/Cobj5.o: In function `Fbcwjs6':
> C5/Cobj5.o(.text+0x10bd8): relocation truncated to fit:
> R_PPC_REL24 calloc@@GLIBC_2.0 .....
>
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
