Message-ID: <3912C0F0.3B3CC7A7@wibble.net>
Date: Fri, 05 May 2000 22:39:12 +1000
From: Steven Hanley <sjh@wibble.net>
MIME-Version: 1.0
To: Sacha Varma <sacha@ssl.co.uk>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SMP/DayStar x4
References: <39128EF2.9E503704@ssl.co.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> only 2 processors are available.
>
> Can anyone set me straight?

very wrong, smp even back when it was added in 1.3.something could
handle more than two AFAIR, it was just very inefficient then. it is now
a lot more efficient and scales a lot better. Dave Miller was using it
on a 14 cpu ultra sparc pre 2.2.0 release, as for ppc, it works on 4 way
ppc, I have no idea how it will work on your specific hardware though.

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
