From: kd@flaga.is
Subject: glibc........ memory limitations.... ideas?
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFFBA23814.6BE68D05-ON00256810.0052B029@flaga.is>
Date: Wed, 20 Oct 1999 15:16:38 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a small question...

We are developing an embedded solution as most of the people here on the
list. This means that we (or at least I) are limited be the amount of
available memory in the units.
We for example are limited by a 2 MB flash chip that might someday be 4MB.
In maybe 1.2MB of this chip I can stuff applications that need to run on
the device.
A statically linked application (with glibc) is arround 300KB (250KB
-450KB).  which means that I can stuff maybe 3-4 statically linked
applications in the flash.

The othre option is to link the applications dinamically to glibc and
stdlibc++. libc-2.1.1.so is around 4 MB and stdlibc++ is around 2.5 MB. So
using dinamically linked
applications  is not even a possibility when you look at it. BTW : Why are
thes libraries so huge!?

Compressed filesystems is one option but that means we have to increase the
size of the DRAM and that again means increased current drain. Limited
battery resources is
one of our contraints also.

How do you guys cram all the software you want into so small space? Are
there any othre c and c++ libraries that are smaller but provides access to
threads (pthreads) and
work with linux?

Thanks, for all inputs.

K.D.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
