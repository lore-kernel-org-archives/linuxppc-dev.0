Date: Thu, 15 Feb 2001 12:48:01 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: Anton Blanchard <anton@linuxcare.com.au>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ltrace for ppc
Message-ID: <20010215124800.A22625@drow.them.org>
References: <20010214081000.A28509@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010214081000.A28509@linuxcare.com>; from anton@linuxcare.com.au on Wed, Feb 14, 2001 at 08:10:00AM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Feb 14, 2001 at 08:10:00AM +1100, Anton Blanchard wrote:
>
> Hi,
>
> ltrace is a cool little program for tracing library calls. I ported it
> to ppclinux a while ago but the ltrace maintainer seems to have ignored
> my patch.
>
> For anyone interested the patch can be found at:
>
> http://linuxcare.com.au/anton/patches/ltrace_ppc_patch
>
> It should apply cleanly to the latest source (I got mine from the debian
> archive).

You did?  Wow!  I spent ages trying to do this...

Oh, looking at your patch I remember what happened.  It's a bloody
miracle that ltrace works at all on any architecture; the PLT tricks
that the PPC plays are not at all uncommon, as I recall.  I got
derailed trying to make it insert breakpoints at the proper time.

Thanks for the patch; I'll probably keep bugging the author about
this...

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
