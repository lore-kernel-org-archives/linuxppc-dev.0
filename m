From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: What's up with gcc 2.95.1 and "__va_arg_type_violation"
Date: Thu, 7 Oct 1999 21:08:16 -0400
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99100721144003.26148@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

When attempting to run the latest build of the jdk, I get the following error
message (but only on non-debug builds).

Unsatisfied Link error: __va_arg_type_violation

Figuring, I simply forgot some new piece of glibc 2.1.2, I used 

nm -o `find /lib -name "*"` | grep va_arg_type  
 
(for /lib, /usr/lib, /usr/local/lib, /opt/lib, etc)

and this damn routine simply does not exist on my machine.

Any ideas of where one might look to fulfill this thing.  This is new with
gcc-2.95.1 and/or glibc 2.1.2


By the way, native threads still do not work with the very latest glibc 2.1.2
because of the new semaphore functions.  If I force linking to the old
semaphore functions, everything starts working again.

I am building a debug glibc 2.1.2 and I will try to find the source of the
problem.

 Any ideas here would be greatly appreciated.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
