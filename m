Message-ID: <00933BFA237CD2119B3400409543582704A280@MEV01>
From: Ian Abbott <abbotti@mev.co.uk>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: A few bugfixes
Date: Fri, 3 Nov 2000 10:20:11 -0000 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote:

> "epicom" wrote:
>
> >  I have found several bugs in versions 2.4.0-test*, I don't
> > know if they
> > exist
> > in 2.2.* versions, but it is posible.
>
> The first two (of three) do.
>
> The first one:
> > >>  return(((unsigned long)(pte_val(*pte)) & PAGE_MASK) | (address &
> > ~(PAGE_MASK-1)));
>
> is logically wrong but I think it is a harmless bug.

Actually, please ignore the bit about it being a harmless bug. I'll
leave that for others to decide. (I don't want to delve into the
virtual memory implementation to work it out for myself, but I'm still
wondering why the function appears to be mostly preserving the upper
bits of the virtual address, rather than the lower bits.)

--
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>             )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587              )=-

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
