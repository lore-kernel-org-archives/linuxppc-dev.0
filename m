Subject: Re: glibc 2.2.2  error
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: rekha gvv <rekhagvvc@yahoo.co.in>
Cc: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20021118122042.74002.qmail@web8001.mail.in.yahoo.com>
References: <20021118122042.74002.qmail@web8001.mail.in.yahoo.com>
Content-Type: text/plain
Date: 18 Nov 2002 14:21:51 +0100
Message-Id: <1037625711.27283.22.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If you read the INSTALL file you would know that --with-headers should
point to the linux kernel headers. I guess the path could be right but
most probably not.


On Mon, 2002-11-18 at 13:20, rekha gvv wrote:
>
> Hello,
> I am setting up glibc for powerpc target but It gives
> me errors ..
> I have set the options
> CC=powerpc-linux-gcc
> ./configure --build=powerpc-linux \
> > --enable-add-ons=linuxthreads \
> > --with-headers=/usr/local/powerpc-linux/include
>
> But when u compile  it is not able to find the headers
> there ...
> it gives these errors ...
> so can anyone specify the right options to configure
> glibc.
>
>
> In file included from ../posix/bits/posix1_lim.h:126,
>                  from :1:
> ../linuxthreads/sysdeps/unix/sysv/linux/bits/local_lim.h:36:26:
> linux/limits.h: No such file or directory
> make[1]: *** [../bits/stdio_lim.st] Error 1
> make[1]: Leaving directory `/usr/src/glibc-2.2.2/csu'
> make: *** [csu/subdir_lib] Error 2
>
>
> thankyou!
>
>
>
--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
