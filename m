MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: how to get the size of a code section.
Date: Thu, 29 Mar 2001 10:00:50 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E310A9123@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am not aware of one, your connection from elf file to application is
Elf32_Ehdr in elf.h.
An example on how to use this structure is in the binary loader in the
kernel, fs/binfmt_elf.c
and you can  read the spec (just do a search for it on google.com).

If you just want to "manage" some elf file sections check out objcopy
and objdump in the binutils package.

K.D.

> -----Original Message-----
> From: Srinivas Rao.M [mailto:msrao@vxl.co.in]
> Sent: 29. mars 2001 08:25
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: how to get the size of a code section.
>
>
>
> Hello to all,
>
>
>  I want to know how do you know the size of a section. suppose if i
> declare a section ".code_in_cache" , is there any C instruction or
> Assembly instruction to know the size of this section. ??
>
> thanks in advance,
> Srini...
>
>
>
> --
>
> We are responsible for what we are, and whatever we wish
> ourselves to be, we
> have the power to make ourselves. If what we are now has been
> the result of
> our own past actions, it certainly follows that whatever we
> wish to be in
> future can be produced by our present actions; so we have to
> know how to act.
> -Swami Vivekananda
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
