Message-ID: <3FC2F1D8.9020400@kegel.com>
Date: Mon, 24 Nov 2003 22:08:24 -0800
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: cjohnson@gcctech.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Tools question
References: <3FC24EB1.60106@gcctech.com>
In-Reply-To: <3FC24EB1.60106@gcctech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Christopher R. Johnson wrote:
> This is probably way too big a question to ask here, but I'm hoping
> someone can help me.  I have inherited a gcc 2.95.3 cross development
> tool chain, which has been working fine to build for my powerpc-linux
> target machine.  I'm building the kernel and user programs fine.  I'm
> beginning to find as I add things in that I'm missing libraries.  Today
> its libresolv which I need for pump.  Some questions:
>
> 1. Do I really need to go back and build my own tool chain?  I've tried
> grabbing 2.95.3 sources and building by running configure with
> --target=powerpc-linux, but I get some missing include file errors
> building libgcc2.a.  I'm on a 405GP (no fp).  Should I even bother doing
> this?

Only if you run into trouble with your old compiler.
If and when you decide to rebuild the compiler, see
http://kegel.com/crosstool for a recipe you can follow.

> 2. On my intel development machine I see that libresolv.a comes from
> glibc-devel-2.2.5-34.  I have gcc-2.96-110 for my compiler.  Should I go
> find a version of glibc-devel that matches up with my existing 2.95.3
> tools?  How will I know if its the right version?

Again, http://kegel.com/crosstool (if you study it, and compare it
with Karim's book) will help show you how to build the glibc of your
choice.

> 3. Better yet, is there somewhere I can just obtain a reasonable tool
> chain that's ready-built for my target machine?  Complete with libraries?

That same URL can show how to build a reasonable toolchain for the ppc405
without any thought on your part, if you choose to not read and
understand the script.  It's always better to read and understand, though.

> Sorry for the newbie type questions.  I have the "Using and Porting GNU
> CC" book, but am finding it a little too Stallman-esque to follow.  Anyone?

Your question is quite reasonable.

BTW, which glibc does your toolchain use?
- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
