Message-ID: <387BECD0.4FFDB494@charter.net>
Date: Tue, 11 Jan 2000 20:54:08 -0600
From: Dan Dickey <ddickey@charter.net>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
CC: Rene Pachernegg <rene.pachernegg@apus.co.at>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Building Glibc
References: <387AEF42.5115A6D9@apus.co.at> <kfyr9fo77re.fsf@kieraypc07.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
