Message-ID: <00933BFA237CD2119B3400409543582704A27F@MEV01>
From: Ian Abbott <abbotti@mev.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: A few bugfixes
Date: Thu, 2 Nov 2000 18:24:39 -0000 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"epicom" wrote:

>  I have found several bugs in versions 2.4.0-test*, I don't
> know if they
> exist
> in 2.2.* versions, but it is posible.

The first two (of three) do.

The first one:
> >>  return(((unsigned long)(pte_val(*pte)) & PAGE_MASK) | (address &
> ~(PAGE_MASK-1)));

is logically wrong but I think it is a harmless bug.

> In the wish to have been useful to improve the PPC port of
> the linux kernel:
>
>
> Luis Recuerda,

Thanks, Luis!

--
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>             )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587              )=-

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
