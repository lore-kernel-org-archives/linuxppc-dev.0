Subject: RE: Memory Pre-allocation (mem=xxx)
Date: Wed, 27 Feb 2002 13:23:33 -0800
Message-ID: <8A098FDFC6EED94B872CA2033711F86F0ABDA8@orion.ariodata.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
From: "David C. Chiu" <dchiu@ariodata.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for all that replied. It would seem that the best possible choice
is probably to just the /proc/cmdline to pass the buffer allocation
size.

-----Original Message-----
From: innkeon@etx.ericsson.se [mailto:innkeon@etx.ericsson.se]On Behalf
Of Kenneth Johansson
Sent: Monday, February 25, 2002 4:36 AM
To: David C. Chiu
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Memory Pre-allocation (mem=xxx)


I'am not shure what you mean with a module driver during boot but If you
want
to pass a option that was entered in the bootline you can read the
bootline
from /proc/cmdline and with some small shell script extract the part you
want
and pass that to the module when you insert it.

"David C. Chiu" wrote:
>
> Thanks for your comment Wolfgang.
>
> The driver in question is compiled as module, and the last time I
> checked (a year ago) there isn't a way to pass an argument to a module
> driver during boot time. Has this changed? The kernel is 2.4 series.
>
> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
Wolfgang
> Denk
> Sent: Friday, February 22, 2002 4:57 PM
> To: David C. Chiu
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Memory Pre-allocation (mem=xxx)
>
> In message <8A098FDFC6EED94B872CA2033711F86F0ABD0C@orion.ariodata.com>
> you wrote:
>
> > We're working on a project that requires a two megabytes block of
> > contiguous memory in kernel space. Although it is well documented
that
> > memory can be reserved by using mem=xx arguments during boot time,
it
> is
> > unclear (to me) as to how a driver can automatically detect the size
> of
> > the said reserved block.
>
> Pass an extra boot argument?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
