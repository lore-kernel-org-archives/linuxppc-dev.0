Message-ID: <374A680D.8B051E6E@dgs.monash.edu.au>
Date: Tue, 25 May 1999 09:06:21 +0000
From: Brendan Simon <brendan@dgs.monash.edu.au>
Reply-To: brendan@dgs.monash.edu.au
MIME-Version: 1.0
To: egcs mailing list <egcs@egcs.cygnus.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        Cross-GCC <crossgcc@cygnus.com>
Subject: can't find crt1.o.  egcs powerpc-linux cross-compile problem.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I am trying to compile egcs-1.1.2 as a cross-compiler (linux to
powerpc).  I am building on a redhat-5.2 system and have successfully
compiled and installed a native egcs-1.12.  I am using this compiler for
the cross-compile build and have used the following configure options.
    --target=powerpc-linux
    --program-prefix=powerpc-linux-
    --with-headers=/usr/include

The compilation of xgcc completes.  At some later stage, configure tries
to test the newly built xgcc to see if it can build executables, but it
fails.  When I run the command manually, the error message says that
"ld" can not find crt1.o.  Where is the source for crt1 (egcs or
glibc) ?  I can see crt1 files in the newlib tree so my first assumption
is that it must be in the glibc tree for linux targets.

Any suggestions to get past my crt1 linking problems.

Thanks,
Brendan Simon.

PS. With regard to the --with-headers option, should I unpack the glibc
sources and point --with-headers to the unpacked include directory,
instead of the original redhat-5.2 ?



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
