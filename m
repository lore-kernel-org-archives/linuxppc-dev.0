Message-ID: <3E1B4678.5050004@mvista.com>
Date: Tue, 07 Jan 2003 15:28:24 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: James Don <JDon@spacebridge.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Whats the "standard" embedded C lib?
References: <DB0585C9F6F9D411BE8F00D0B7896A4CC05FC8@SNCMAIL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James Don wrote:
> Hi there,
>
> I am just looking at compiling "busybox". And am now at a point where I need
> to consider more than just the kernel and my bootloader.
>
> I have build my gcc 2.95.3 using newlib (from redhat I believe) ...

newlib is only used as a bootstrap mechanism before you build a "real" C library.

> I am having some troubles building busy box ... as I need to sort our which
> 'headers' to include etc ...
>
> I think I am on the right track to completing this but I read something in
> the busy box makefile that kind of stirred my confidence ... it said uClib
> is best with busy box ... is this the same as newlib?

busybox will work with uclibc or glibc.  I recommend glibc, but due to size
limitations you may want to use uclibc.  (Be aware that uclib isn't as well
supported on PPC.  At least wasn't last time I looked..)

> What embedded C lib do you folks recommend? (for PPC 860 if that matters)

glibc is much larger then uclibc, but is a "full featured" c library (w/ shared
library support).  There many ways to shrink down the size of glibc to something
more manageable for an embedded project, but it will probably still not be as
small as uclibc.

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
