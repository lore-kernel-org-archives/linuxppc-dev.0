Message-ID: <17B78BDF120BD411B70100500422FC63079FA0@IIS000>
From: Patrick Lerda <Lerda@microprocess.com>
To: "'Dan Malek'" <dan@netx4.com>, Patrick Lerda <Lerda@microprocess.com>
Cc: Nguyen Xuan Hoang <hoang_nguyen@op.com.sg>,
        linuxppc-embedded@lists.linuxppc.org
Subject: RE: MMU problems?
Date: Fri, 23 Jun 2000 09:43:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The things work better on our board now. The main problem, with 8xx kernel
patches are spread everywhere, and kernel like mpc8xx contains
a lot of useless changes that make the changes difficult to resync with the
main
serie. Kernel like 2.2.16 works properly and reliably on PPC7xx and PPC6xx
processors,
with a lot of PCI drivers functionnal now. I think the main effort will be
to resync 8xx kernels
with the standard ones. Now I have a patched 2.2.16 kernel that seems to
work on our board. Complex operations like compiling a kernel
take hours to complete on a 8xx board, and the bugs seems to have a low
probability.

(With the classic mpc8xx kernel, the system crash after only 20 minutes
while compiling
a kernel)

I have some success with theses kernel now, but I'm not sure if some bugs
remains, testing this system takes now hours... And this is quite
undebugable...

Patrick LERDA



> -----Message d'origine-----
> De:	Dan Malek [SMTP:dan@netx4.com]
> Date:	jeudi 22 juin 2000 17:58
> À:	Patrick Lerda
> Cc:	Nguyen Xuan Hoang; linuxppc-embedded@lists.linuxppc.org
> Objet:	Re: MMU problems?
>
> Patrick Lerda wrote:
> >
> > Have you tried to do complex operation on a 8xx board like compiling the
> > kernel.
>
> Yes, and it runs just like any other system that doesn't have any
> swap space and a minimal amount of memory.  Some things just don't
> work well, and applications fail because few test for memory allocation
> failure.
>
> Are there bugs?  Perhaps.  Do I want them fixed?  Yes.
>
> Do you want to help this FREE software effort?  If you are so sure
> there is an MMU bug, find it, fix it, and send me the patch.  We would
> all be grateful.  If you want dedicated help to assist your custom
> product development so you can make money, you may have to pay one
> of the very capable embedded Linux companies for this attention.
>
> Thanks.
>
>
> 	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
