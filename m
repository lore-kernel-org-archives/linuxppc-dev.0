Message-Id: <200204190817.RAA27670@mail.highway.ne.jp>
Date: Fri, 19 Apr 2002 17:14:38 +0900 (JST)
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: asm info
To: pochini@shiny.it
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <XFMail.20020419093710.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 19 Apr, Giuliano Pochini wrote:
>
> I want to write some small functions/peices of code in
> ppc assembly. I have ppc user manuals and the ABI, but
> I don't know the syntax. I need to know how to code asm
> inside the C source, and I need to know how to write a
> .S file to assemble and link with C object files. Where
> can I find the docs ?  Does gcc support Altivec ?

Hi!

 ftp://ppc.linux.or.jp/pub/users/fukui

There are newer binutils and gcc-3.1.pre.
Those have Altivec instruction.
gcc-3.1 will be switch to altivec with -maltivec.

But If you want to altivec code,
It need the source which is written by altivec register.
See www.altivec.org about altivec.

Anyway, Try to write simple c source.
Then

gcc -S simple.c

You get simple.s

The simple.s is written by asmppc.

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
