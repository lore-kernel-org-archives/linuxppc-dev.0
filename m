Date: Mon, 13 Sep 1999 16:37:55 -0400
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: hfs resource forks in Linux
Message-ID: <19990913163755.A310@them.org>
References: <19990913190525.5485.rocketmail@web1006.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19990913190525.5485.rocketmail@web1006.mail.yahoo.com>; from Dan Bethe on Mon, Sep 13, 1999 at 12:05:25PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Not quite what I was talking about.  These let us touch the resource
fork, and deal with hfs volumes, not manage a specific file's resource
fork on the resource level.

On Mon, Sep 13, 1999 at 12:05:25PM -0700, Dan Bethe wrote:
> 
> 	Hi guys.  In another thread, I saw someone ask for technique to
> sensibly manage HFS resource forks in Linux.  Here are the following
> two tools I've known.  'hfstools' is pretty flexible, and will do
> encoding conversions (macbinary, binhex, etc) on the fly.  Tons of
> options available in that one.  I dont know about hfsutils-devel other
> than that it's a C library, and the rpm I found was only for i386 but
> it's obviously got the docs.
> 	I'm not sure if this is suitable for any advanced or particular use
> other than general file management, but it's all I know.  I found these
> on www.linuxnow.com's search engine.
> 
> ftp://ftp.varesearch.com/pub/mirrors/redhat/roughcuts/ppc/SRPMS/hfsutils-3.2-1b.src.rpm
> 
> ftp://ftp.varesearch.com/pub/mirrors/redhat/redhat/powertools/5.2/i386/hfsutils-devel-3.2-1.i386.rpm
> ===
> "We can learn from the past, but those days are gone.
> We can hope for the future, but there may not be one."
> -- http://www.dreamtheater.net/songb5.htm#VI1
> 


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
