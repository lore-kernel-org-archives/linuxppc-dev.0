Date: Tue, 22 Aug 2000 01:45:12 +0900 (KST)
From: Seong-kyu Ko <sugenius@doit.ajou.ac.kr>
To: Mike Wolf <mwolf@cray.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems using shared library in corss environment
In-Reply-To: <39A15A1D.5B3A1E18@cray.com>
Message-ID: <Pine.LNX.4.21.0008220142100.27366-100000@doit.ajou.ac.kr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 21 Aug 2000, Mike Wolf wrote:

>
> Seong-kyu Ko wrote:
> >
> > Hi everybody.
> > First, I'm sorry for my weak English, but please read my problem and help
> > me.
> >
> > I have some problems in building a powerpc corss compiler environment.
> > I'm now trying to build a cross environment, the host is i386 and target
> > is powerpc.
> >
> > These are the packages that I used.
> > 1. binutils-2.10
> > 2. gcc-2.95.2
> > 3. glibc-2.1.3 (add-ons : glibc-crypt-2.1, glibc-linuxthreads-2.1.3)
> >
> > First, I compile the binutils for powerpc cpu.
> > Second, I build cross compiler with gcc.
> > Third, I compile glibc for powerpc with cross compiler that I made.
> > Last, I re-build cross compiler include glibc for library.
> >
> > And I compiled kernel with cross compiler that I made.
> > Yeah, it's ok. And I compile 'init' with static library.
> >
> > but I compile shell with shared labrary, it use ld.so.1 and libc.so.6
> > The problem is ld.so.1 can't found libc.so.6
> > The error message is this :
> > 'error in loading shared libraries: libc.so.6: cannot open shared object
> > file: No such file or directory'
> >
> > Please tell me why it can't find that and how can I solve this problem.
> > I'll wait your answers.
> > thank you.
> >
> You probably have the shared libs in the wrong location.  Where ever
> they
> reside on you cross compiler is where they will need to reside in the
> ppc
> tree.  So instead of putting them in /lib or /usr/lib put them in
> /home/.../target/powerpc-linux-gnu/lib or whatever directory the libs
> were
> installed into when you made the cross compiler.
>
> If you are NFS mounting the root dir then you can use snoop to see
> where ld.so is looking for the shared libs.
>
> --
> Mike Wolf
> Cray Inc
> 655-F Lone Oak Drive, Eagan, MN 55121
> mwolf@cray.com          (651)683-5313


Thank you for your answer but I put the libs /lib.
So I think it's not the problem of the worng location.
Sorry.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
