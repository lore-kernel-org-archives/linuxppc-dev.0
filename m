Date: Mon, 18 Nov 2002 10:53:27 -0600
From: "William A. Gatliff" <bgat@billgatliff.com>
To: rekha gvv <rekhagvvc@yahoo.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc 2.2.2  error
Message-ID: <20021118105327.G5212@saturn.billgatliff.com>
Reply-To: bgat@billgatliff.com
References: <20021118122042.74002.qmail@web8001.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021118122042.74002.qmail@web8001.mail.in.yahoo.com>; from rekhagvvc@yahoo.co.in on Mon, Nov 18, 2002 at 04:20:42AM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rekha:


Is your kernel source tree configured?

b.g.

On Mon, Nov 18, 2002 at 04:20:42AM -0800, rekha gvv wrote:
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
Bill Gatliff
Do you do embedded GNU?  I do!
See http://billgatliff.com for details.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
