Message-ID: <19991025101727.A4528@maxime.u-strasbg.fr>
Date: Mon, 25 Oct 1999 10:17:27 +0200
From: Sven LUTHER <luther@maxime.u-strasbg.fr>
To: Gabriel Paubert <paubert@iram.es>, Sean Chitwood <darkmane@w-link.net>
Cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Modern PowerPC Assembly?
Reply-To: luther@dpt-info.u-strasbg.fr
References: <Pine.LNX.4.10.9910221357090.676-100000@darkmane.w-link.net> <Pine.HPX.4.10.9910230020330.21757-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.9910230020330.21757-100000@gra-ux1.iram.es>; from Gabriel Paubert on Sat, Oct 23, 1999 at 12:34:21AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Oct 23, 1999 at 12:34:21AM +0200, Gabriel Paubert wrote:
> 
> 
> 
> On Fri, 22 Oct 1999, Sean Chitwood wrote:
> 
> > 
> > Can anyone recommend a book or website for PPC Assembly Programming? 
> > 
> 
> It depends on what you exactly mean and your level. For smart tricks look
> for the Compiler Writer's Guide somewhere on IBM's site. I've personnally
> learnt PPC assembly from reading the architecture specification and got
> some more useful tricks from the Compiler Writer's Guide.
> 
> <Shameless plug> 
> 
> For an example of a fairly large (but still comprehensible IMHO) assembly
> program, you may have a look at my em86 program on ftp://vlab1.iram.es.
> 
> This is an emulator for x86 BIOSes which allows me to initialize my S3.
> It's quite heavily commented and the emulation of flags has been designed
> to make clever use of rlwimi and cntlzw instructions. OTOH the decoding
> of addressing modes is quite awful spaghetti (but this was faster than 
> indirect branches). Plus the mixture of little and big endian made it very
> funny to write...
> 

Gabriel, ...

Do you think it would be possible to use your emulator to have a ppc
based dosemu ?

Not that i have time for it right now, but ...

Friendly,

Sven LUTHER

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
