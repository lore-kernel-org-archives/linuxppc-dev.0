Message-ID: <20020417221119.95267.qmail@web21108.mail.yahoo.com>
Date: Wed, 17 Apr 2002 15:11:19 -0700 (PDT)
From: murali venkateshaiah <mvenkat_ml@yahoo.com>
Subject: library optimizer issues 
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Folks:

I am trying to use HardHat Journeyman edition (without
x86 tools)...hence the need to use library opt in
public domain and I cannot seem to get it going..

I copied the scripts libindex, libopt into ~home/bin
along with objdump and nm for x86

1. how do I create the path/index and build scripts?
   what is the procedure to build the path/index
files?

   target/ - src directory
   /bin /lib  - 2 dirs with utils in bin, libraries in
lib

   newtarget/ - new dest directory

   libopt -s -d newtarget -s target - seems to run and
produce output as below.

2. I turned on optdebug in libopt and I see this
output below, the self.optimizer always returns None.
..
..
Resolve target/lib/ld-linux.so.2
_dl_check_map_versions GLIBC_2.2 None
Resolve target/lib/ld-linux.so.2
__key_encryptsession_pk_LOCAL GLIBC_2.1
None
Resolve target/lib/ld-linux.so.2
__libc_internal_tsd_get GLIBC_2.0 None
Resolve target/lib/ld-linux.so.2 _res GLIBC_2.0 None


..
..
Does this say anything? Is step-1 the issue?

3. If I were to create the index manually for a huge
project with  many .o's ..it seems pretty hard to do
that, not knowing all the shlibs might be using.

Since I might build .os for a whole project heirarchy,
how can I figure out the .o's I need for each
sharedlib (eg glibc-2.2.5) for libindex?  How do I use
libindex to create the indexes ?

Any help is very appreciated. Thanks.
-Murali
mvenkat_ml@yahoo.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
