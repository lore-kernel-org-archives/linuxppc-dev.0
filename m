Message-ID: <380E157D.32E9F950@netx4.com>
Date: Wed, 20 Oct 1999 15:18:21 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: kd@flaga.is
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc........ memory limitations.... ideas?
References: <OFFBA23814.6BE68D05-ON00256810.0052B029@flaga.is>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


kd@flaga.is wrote:


> Compressed filesystems is one option but that means we have to increase the
> size of the DRAM and that again means increased current drain. Limited
> battery resources is
> one of our contraints also.

Just because I need to learn something today, does memory really take
that much power?


> How do you guys cram all the software you want into so small space?

I am still using the old R4 libc-1.99 and associated libararies
for this reason.

One of the differences is that glibc2 just simply has more stuff
in it, which was contained in separate libraries of the past.  If
you want lots of the workstation features in your embedded system,
you will still end up with lots of library space used.

> ... Are
> there any othre c and c++ libraries that are smaller but provides access to
> threads (pthreads) and
> work with linux?


Here again, I am a minimalist.  I don't use pthreads, as the
implementation is very heavyweight.  I just use Linux threads and
some simple atomic operations for synchronization.  I certainly
don't use C++ in a resource constrained embedded environment.
All of my embedded applications have used compressed ram disks
in Flash rom....It doesn't take long before you have an application
that needs a temporary file of some kind.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
