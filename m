Subject: RE: Memory Pre-allocation (mem=xxx)
Date: Fri, 22 Feb 2002 19:11:00 -0800
Message-ID: <8A098FDFC6EED94B872CA2033711F86F0ABD19@orion.ariodata.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
From: "David C. Chiu" <dchiu@ariodata.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the response. Would you be so kind to be more specific? I did
a coarse search of the kernel documentation subdirectory contents, but
fail to find what you are referring to (although I have been referred to
as the seeing blind in the past.)

The basic goal was to have a singular location in which buffer size is
specified so that future changes doesn't turn into a nightmare, and
computing the delta between mem=xxx and actual memory size seem logical,
but the present method employed by yours truely felt ugly and... so
wrong. ^^;

-----Original Message-----
From: Tom Rini [mailto:trini@kernel.crashing.org]
Sent: Friday, February 22, 2002 6:38 PM
To: Wolfgang Denk
Cc: David C. Chiu; linuxppc-embedded@lists.linuxppc.org
Subject: Re: Memory Pre-allocation (mem=xxx)


On Sat, Feb 23, 2002 at 01:57:24AM +0100, Wolfgang Denk wrote:
> In message <8A098FDFC6EED94B872CA2033711F86F0ABD0C@orion.ariodata.com>
you wrote:
> >
> > We're working on a project that requires a two megabytes block of
> > contiguous memory in kernel space. Although it is well documented
that
> > memory can be reserved by using mem=xx arguments during boot time,
it is
> > unclear (to me) as to how a driver can automatically detect the size
of
> > the said reserved block.
>
> Pass an extra boot argument?

Basically.  IIRC there's a clean way to do it now (tho it can fail, so
you'd have to catch that in the driver, but early on it shouldn't be a
problem).  Look around in Documentation/

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
