Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC05FCB@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Whats the "standard" embedded C lib?
Date: Tue, 7 Jan 2003 16:38:40 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the info ...

I now think I remember reading that about newlib from when I built the gcc
cross-compilers in september ...

I will do some reading on glibc and uclibc to see what I should pick tonight
...

Thanks again for the tip,
Jim



-----Original Message-----
From: Mark Hatle [mailto:fray@mvista.com]
Sent: Tuesday, January 07, 2003 4:28 PM
To: James Don
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: Whats the "standard" embedded C lib?

James Don wrote:
> Hi there,
>
> I am just looking at compiling "busybox". And am now at a point where I
need
> to consider more than just the kernel and my bootloader.
>
> I have build my gcc 2.95.3 using newlib (from redhat I believe) ...

newlib is only used as a bootstrap mechanism before you build a "real" C
library.

> I am having some troubles building busy box ... as I need to sort our
which
> 'headers' to include etc ...
>
> I think I am on the right track to completing this but I read something in
> the busy box makefile that kind of stirred my confidence ... it said uClib
> is best with busy box ... is this the same as newlib?

busybox will work with uclibc or glibc.  I recommend glibc, but due to size
limitations you may want to use uclibc.  (Be aware that uclib isn't as well
supported on PPC.  At least wasn't last time I looked..)

> What embedded C lib do you folks recommend? (for PPC 860 if that matters)

glibc is much larger then uclibc, but is a "full featured" c library (w/
shared
library support).  There many ways to shrink down the size of glibc to
something
more manageable for an embedded project, but it will probably still not be
as
small as uclibc.

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
