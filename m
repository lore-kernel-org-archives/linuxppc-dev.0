Message-ID: <37DD5EE7.51F3F340@wanadoo.fr>
Date: Mon, 13 Sep 1999 22:30:31 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Dan Bethe <dan_bethe@yahoo.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: hfs resource forks in Linux
References: <19990913190525.5485.rocketmail@web1006.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Bethe wrote:
> 
>         Hi guys.  In another thread, I saw someone ask for technique to
> sensibly manage HFS resource forks in Linux.  Here are the following
> two tools I've known.  'hfstools' is pretty flexible, and will do
> encoding conversions (macbinary, binhex, etc) on the fly.  Tons of
> options available in that one.  I dont know about hfsutils-devel other
> than that it's a C library, and the rpm I found was only for i386 but
> it's obviously got the docs.
>         I'm not sure if this is suitable for any advanced or particular use
> other than general file management, but it's all I know.  I found these
> on www.linuxnow.com's search engine.
> 
> ftp://ftp.varesearch.com/pub/mirrors/redhat/roughcuts/ppc/SRPMS/hfsutils-3.2-1b.src.rpm
> 
> ftp://ftp.varesearch.com/pub/mirrors/redhat/redhat/powertools/5.2/i386/hfsutils-devel-3.2-1.i386.rpm

There is a hfsutils-3.2.6-1.ppc.rpm (and a corresponding -devel-) on
ftp.linuxppc.org in the contrib directory, and YDL has something
similar.

It is still a mystery for me why this package is not included in the
LinuxPPC-dev-rel, nor on the LinuxPPC CD. I think this is a basic
necessity for anyone using LinuxPPC on a Pmac. Fortunately, RedHat
continues to develop it in its rawhide/powertools collection.

On 2.3.xx kernels, the hfs system is broken, and it doesn't look like it
will be fixed in the near future*). So for me at least, hfsutils is
essential to copy things like new kernels to the MacOS system folder
without having to boot MacOS.

*) I saw a message on linux-kernel in which A. Sun, the maintainer of
the hfs code, said that it's on his todo list, but right now "on the
back burner". If that's true and nobody else steps in, we won't see HFS+
support in this century either.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
