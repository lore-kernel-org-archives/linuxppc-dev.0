Message-ID: <3C17A868.605B0BED@ualberta.ca>
Date: Wed, 12 Dec 2001 11:56:40 -0700
From: Jesse McCrosky <mccrosky@ualberta.ca>
MIME-Version: 1.0
To: LinuxPPC Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: link error with jdk-1.3
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just downloaded the the blackdown powerpc port of jdk-1.3.
Unfortunately there
seems to be some sort of link error.

When I try to run java I get the following error.

/usr/src/j2sdk1.3/jre/bin/ppc/native_threads/java: error while loading
shared libraries: /usr/src/j2sdk1.3/jre/lib/ppc/classic/libjvm.so:
symbol __register_frame_info, version GLIBC_2.0 not defined in file
libc.so.6 with link time reference

I was actually getting a similar error on realpath before, but I hand
edited the .java_wrapper file to replaace realpath references with
absolute pathnames, foolishly thinking this would solve my problem...

I am using glibc-2.2.4

Any ideas?

Thanks.

--
	jesse McCrosky
	mccrosky@ualberta.ca
	GPG Public Key: http://www.ualberta.ca/~mccrosky/public_key.asc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
