Message-ID: <3C7A2FA4.E111C24D@etx.ericsson.se>
Date: Mon, 25 Feb 2002 13:35:48 +0100
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
MIME-Version: 1.0
To: "David C. Chiu" <dchiu@ariodata.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Memory Pre-allocation (mem=xxx)
References: <8A098FDFC6EED94B872CA2033711F86F0ABD14@orion.ariodata.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'am not shure what you mean with a module driver during boot but If you want
to pass a option that was entered in the bootline you can read the bootline
from /proc/cmdline and with some small shell script extract the part you want
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
> Wolfgang Denk
> Sent: Friday, February 22, 2002 4:57 PM
>
> In message <8A098FDFC6EED94B872CA2033711F86F0ABD0C@orion.ariodata.com>
> you wrote:
>
> > We're working on a project that requires a two megabytes block of
> > contiguous memory in kernel space. Although it is well documented that
> > memory can be reserved by using mem=xx arguments during boot time, it
> is
> > unclear (to me) as to how a driver can automatically detect the size
> of
> > the said reserved block.
>
> Pass an extra boot argument?

--
Kenneth Johansson
Ericsson Telecom                  Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
