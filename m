Subject: Re: Compiling the kernel using a Bitkeeper tree
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1086268009.5981.38.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Thu, 03 Jun 2004 15:06:49 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I think I'm never gonna learn that this list doesn't add
a "Reply-To:" header...

On Thu, 2004-06-03 at 13:00, rdiz@alumni.deec.uc.pt wrote:
> Hi,
>
> I'm using bitkeeper for the first time, and I find myself unable to compile
> a kernel from the linuxppc-2.5-benh tree I "cloned".
>
> It might be a naive question, but don't get how one can compile it. I
> don't even find a Makefile in my root rep directory, and I haven't chose
> the compilations options yet... Using a gziped kernel all I had to do was
> something like "make ARCH=ppc CROSS_COMPILE=powerpc-linux- menuconfig".

When you clone a tree, it's not checked out. Think of a bk tree like
a cvs repository interleaved with yor working directory. All you have
now is the repository, but no checked-out working copy.

I suggest to read http://www.bitkeeper.com/Documentation.FAQS.Linux.html

Some hints:
- You can configure your bk tree in "checkout-get mode"
- To see/edit individual files, use "bk get"/"bk edit"
  It's just like with "cvs co"/"cvs edit", but both is mandantory
- make and patch know how to check out files automagically
- run "bk helptool"
- see linux/Documentation/BK-usage
- see http://www.bitkeeper.com/cvs2bk.html

--
Stefan Nickl
Kontron Modular Computers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
