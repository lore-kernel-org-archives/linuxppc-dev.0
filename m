Subject: Re: cross-compiling problems (linux to ppc)
From: Hollis Blanchard <hollisb@us.ibm.com>
To: sting sting <zstingx@hotmail.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Sea2-F28k1Ixzl4anSs00047d9a@hotmail.com>
References: <Sea2-F28k1Ixzl4anSs00047d9a@hotmail.com>
Content-Type: text/plain
Message-Id: <1080752139.26315.5.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Date: Wed, 31 Mar 2004 10:55:39 -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-03-31 at 05:17, sting sting wrote:

> Now , I had followed the instructions on :
> http://penguinppc.org/embedded/cross-compiling/

> ../../gcc-3.3.2/gcc/config/rs6000/linux.h:89:20: signal.h: No such file or d
> tory
> In file included from tconfig.h:22,
>                  from ../../gcc-3.3.2/gcc/libgcc2.c:36:
> ../../gcc-3.3.2/gcc/config/rs6000/linux.h:98: error: parse error before "sta
> "
> ../../gcc-3.3.2/gcc/config/rs6000/linux.h:98: warning: no semicolon at end o
> ruct or union

There's a patch you can apply listed on the page (read carefully). It
will only work if you only want to build kernels (i.e. no glibc, no
userspace).

The other alternative is to install *target* kernel headers (not
/usr/include) and build against those. This is just silly if you don't
want glibc, but the toolchain people are apparently too busy to care.

--
Hollis Blanchard
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
