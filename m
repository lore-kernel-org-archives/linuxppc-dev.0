From: kd@flaga.is
Subject: Re: Building Glibc
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFC4189FBA.BDDFDE4A-ON00256864.003F955A@flaga.is>
Date: Wed, 12 Jan 2000 11:37:33 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



And of course what binutils. That was a stumbling block for me, i.e. if it
is glibc 2.1.2. Buildin glibc 2.1.2 on ppc requieres binutils later than
version (or equal) 2.9.4.
I used 2.9.5 with success.

K.D.


                                                                                                                                                    
                    Dan Dickey <ddickey@charter.net>                                                                                                
                    Sent by:                                To:                                                                                     
                    owner-linuxppc-embedded@lists.li        cc:                                                                                     
                    nuxppc.org                              Subject:     Re: Building Glibc                                                         
                                                                                                                                                    
                                                                                                                                                    
                    01/12/2000 02:54 AM                                                                                                             
                                                                                                                                                    
                                                                                                                                                    





Marcus Sundberg wrote:
>
> "Rene Pachernegg" <rene.pachernegg@apus.co.at> writes:
>
> > Hello,
> >
> > When building the GNU libc on a cross-compiler (i686 --> PowerPc 603e)
> > I get the following linker error (current directory: elf):
> > ../libc_pic.a(init-first.os): In function '_dl_start':
> > init-first.os(.text+0xb8): multiple definition of '_dl_start'
> > dl-allobjs.os(.text0x0): first defined here Warning: size of symbol
> > '_dl_start' changed from 1576 to 16 in init-first.os collect2: ld
> > returned 1 exit status make[1]: *** [librtld.os] Error 1 make: ***
> > [elf/subdir_lib] Error2
> >
> > What can I do? Are there special linker/compiler options?
>
> What version of glibc are you using?
> How did you configure glibc?
> What make command line (s) did you use?

I'd also chime in with,
What version of the compiler are you using?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
