Message-ID: <000b01c11134$81939930$2502a8c0@cwx053a>
From: "David Burg" <david.burg@nero.com>
To: <linuxppc-dev@lists.linuxppc.org>
References: <002a01c11120$1895f130$2502a8c0@cwx053a>
Subject: Re: R_PPC_REL24 relocation out of range
Date: Fri, 20 Jul 2001 17:56:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello again,

I "simply"* need to update my tool chain. The bug seems to be fixed in newer
release.

Sorry for disturbing you,

David Burg.
*: compiler compilation, so much fun and crasy error messages...
----- Original Message -----
From: "David Burg" <david.burg@nero.com>
To: <linuxppc-dev@lists.linuxppc.org>
Sent: Friday, July 20, 2001 3:30 PM
Subject: R_PPC_REL24 relocation out of range


>
> Hello,
>
> I'm making cross-compilation from x86 to powerpc and I got such nice error
> while executing :
> dlopen: ./libf.so: R_PPC_REL24 relocation at 0x6fdb6458 for symbol
> `L_OFFSET_TABLE_' out of range
>
> With dynamic linked libraries. Making a search on the internet, I have
seen
> someone got the same trouble :
>
> http://lists.linuxppc.org/listarcs/linuxppc-dev/200003/msg00025.html
>
> I try this simple program and got the error with the cross-compiler (a
> powerpc-linux-gcc 2.95.2 with matching g++ and ld behind). This web page
was
> of previous year, so I bet there exist a fix now but I can't find it.
>
> I allready use -fpic -fPIC flags to my g++ calls. Note that the bug happen
> when cross-compiling the libraries but not when localy compiling the
> libraries.
>
>
>
> Best regards,
>
> David Burg.
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
