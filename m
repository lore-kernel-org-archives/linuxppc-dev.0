Message-Id: <20011020162513.Postino-002980@smtp01.highway.ne.jp>
Date: Sat, 20 Oct 2001 16:25:13 +0900
To: <manu@stapf.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: Error when linking
In-Reply-To: <001701c15935$5b6acff0$f5732c0c@venice2>
References: <001701c15935$5b6acff0$f5732c0c@venice2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: "Emmanuel STAPF" <manu@stapf.org>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Error when linking
Date: Sat, 20 Oct 2001 00:03:44 -0700

>
> Hi,
>
> When compiling a big system composed of about 1000 c files, I get a lot
> of errors such as reproduced below. Is there a solution to this problem?
>
> Thanks,
> Manu
>
> /usr/lib/crt1.o: In function `_start':
> /usr/lib/crt1.o(.text+0x20): relocation truncated to fit: R_PPC_REL24
> __libc_start_main@@GLIBC_2.0
> /usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegin.o: In
> function `__do_global_dtors_aux':
> /usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegin.o(.text+
> 0x94): relocation truncated to fit: R_PPC_PLTREL24
> __deregister_frame_info@@GLIBC_2.0
> /usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegin.o: In
> function `frame_dummy':
> /usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/3.0.1/crtbegin.o(.text+
> 0x12c): relocation truncated to fit: R_PPC_PLTREL24
> __register_frame_info@@GLIBC_2.0
> C1/Cobj1.o: In function `Facss3c':
> C1/Cobj1.o(.text+0x1480c): relocation truncated to fit: R_PPC_REL24
> __sigsetjmp@@GLIBC_2.0

Glibc has those rabel.
You can check with nm command

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
