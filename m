Message-ID: <3A70EAB7.C46E3CD3@mvista.com>
Date: Thu, 25 Jan 2001 19:10:47 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Hua Ji <hji@netscreen.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: About TLB mapping
References: <A33AEFDC2EC0D411851900D0B73EBEF7063E87@NAPA>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hua Ji wrote:
>
> Hi, folks,
>
> Advice needed.
>
> I am writting my TLB mapping for 405GP 128M physical memory.
> When I try to assemble my codes. I got some error called:
> "Unrecognized opcode: tlbwe".

Why are you doing this?  Is something wrong with the existing
implementation?


> I am confused and am asking for help. Thanks in advance.
>
> Or do I missed some options for my make file? My working environment is:
> *  powerpc-eabi-gcc and corresponding as....
> *  I tried to use -mcpu=405 to let as know that I am expecting 405cpu:-)

I don't know of any compiler that has -mcpu=405 (yet).  Use -mcpu=403.


> #-------------
> #Error Message I got from compiler and assember
> #------------------------------------------
>  : Error: Unrecognized opcode: `tlbwe'
>  : Error: Unrecognized opcode: `tlbwe'
>
> #-------------
> #My codes sample
> #-----------------------------------------------------
>  li      %r0,0                 #TLB Entry 0
>  tlbwe  %r4,%r0,1
>  tlbwe  %r3,%r0,0
> #-----------------------------------------------------

Thanks,

Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
