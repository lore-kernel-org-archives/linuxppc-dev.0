Message-ID: <387C97CF.8F915DCF@apus.co.at>
Date: Wed, 12 Jan 2000 16:03:43 +0100
From: "René Pachernegg" <rene.pachernegg@apus.co.at>
MIME-Version: 1.0
To: kd@flaga.is
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Building Glibc
References: <OF82C403B0.A1CFD276-ON00256864.0048B24C@flaga.is>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to build the newest gcc as my powerpc-cross-compiler now
(without installing the new gcc as my native compiler;is this really
necessary?), but I have still problems with the configure options:

--with-headers and
--with-libs
All I have untill now is the cross-compiled kernel and it's header
files.  Is it right to set --with-headers to this dir?
What to do with -with-libs?
Got the message: 
cant find stdlib.h
cant find unistd.h

	Regards
		Rene
kd@flaga.is wrote:
> 
> I have an debian system so I upgraded my gcc to 2.95.2 and binutils to
> 2.9.5 just by inserting the appropriate packages on the system and
> resolving conflicts/dependencies.
> That was necessary (I think) to build the cross compiler (version 2.95.2
> also) and the cross binutils (also version 2.9.5). Now I had the
> tools to build the glibc-2.1.2 for the ppc.
> 
> So I ended up installing the latest gcc and binutils in order to compile
> the latest cross-gcc and glibc.
> 
> Check the documentation for glibc (if you havent allready) it mentions the
> minimum version requirements for all the tools.
> 
> K.D.
> 
> 
>                     "René Pachernegg"
>                     <rene.pachernegg@apus.co.at>            To:     kd@flaga.is
>                     Sent by:                                cc:     linuxppc-embedded@lists.linuxppc.org
>                     owner-linuxppc-embedded@lists.li        Subject:     Re: Building Glibc
>                     nuxppc.org
> 
> 
>                     01/12/2000 12:29 PM
> 
> 
> 
> typing 'as -v' writes:
> GNU assembler version 2.9.1, using BFD version 2.9.1.0.25
> If this is what you mean, how can I get the version 2.9.5?
> Do I have to install a new compiler?
> 
> Regards
>      Rene
> 
> kd@flaga.is wrote:
> >
> > And of course what binutils. That was a stumbling block for me, i.e. if
> it
> > is glibc 2.1.2. Buildin glibc 2.1.2 on ppc requieres binutils later than
> > version (or equal) 2.9.4.
> > I used 2.9.5 with success.
> >
> > K.D.
> >
> >
> >                     Dan Dickey <ddickey@charter.net>
> >                     Sent by:                                To:
> >                     owner-linuxppc-embedded@lists.li        cc:
> >                     nuxppc.org                              Subject:
> Re: Building Glibc
> >
> >
> >                     01/12/2000 02:54 AM
> >
> >
> >
> > Marcus Sundberg wrote:
> > >
> > > "Rene Pachernegg" <rene.pachernegg@apus.co.at> writes:
> > >
> > > > Hello,
> > > >
> > > > When building the GNU libc on a cross-compiler (i686 --> PowerPc
> 603e)
> > > > I get the following linker error (current directory: elf):
> > > > ../libc_pic.a(init-first.os): In function '_dl_start':
> > > > init-first.os(.text+0xb8): multiple definition of '_dl_start'
> > > > dl-allobjs.os(.text0x0): first defined here Warning: size of symbol
> > > > '_dl_start' changed from 1576 to 16 in init-first.os collect2: ld
> > > > returned 1 exit status make[1]: *** [librtld.os] Error 1 make: ***
> > > > [elf/subdir_lib] Error2
> > > >
> > > > What can I do? Are there special linker/compiler options?
> > >
> > > What version of glibc are you using?
> > > How did you configure glibc?
> > > What make command line (s) did you use?
> >
> > I'd also chime in with,
> > What version of the compiler are you using?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
