Message-ID: <372E6B45.92CCD632@dgs.monash.edu.au>
Date: Tue, 04 May 1999 03:36:37 +0000
From: Brendan Simon <brendan@dgs.monash.edu.au>
Reply-To: brendan@dgs.monash.edu.au
MIME-Version: 1.0
To: Cross-GCC <crossgcc@cygnus.com>, egcs mailing list <egcs@cygnus.com>,
        linuxppc-user <linuxppc-user@lists.linuxppc.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: egcs-1.1.2 powerpc cross-compiler question.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've tried building egcs-1.1.2 as a powerpc-eabi cross compiler and a
powerpc-linux cross compiler.  I had instructions from the LinuxPPC web
site on building the powerpc-linux cross compiler.  The configure
command was "configure --target=powerpc-linux --with-newlib".  The only
difference between my setup and the instructions on the web site is that
I am using the FULL egcs-1.1.2 source where as the instructions were for
the CORE egcs-1.1.2 source.  I want to use C and C++ so I used the full
distribution.  The error message I am getting looks like its related to
the objective C build which I don't need but I am interested in trying
it one day.  The errors are:

egcs-1.1.2/gcc/objc/runtime.h:31 stdio.h: No such file or directory
egcs-1.1.2/gcc/objc/runtime.h:31 ctype.h: No such file or directory

I did not have these problems building the native linux build of
egcs-1.1.2.  It obviously knows how/where to find the appropriate
headers.

How can I get the objc build to find the appropriate header files ?
Can I just delete the gcc/objc directory to avoid building objc ?

The CONFIGURE file in the INSTALL directory says that if you use
--enable-languages=c++ then the other languages will be omitted.  I
tried that but I still get the above error messages indicating that the
objc compiler is trying to be built.

Thanks,
Brendan Simon.

PS. The other difference I had to the LinuxPPC howto, is I included
--program-prefix=powerpc-linux- when building egcs and binutils.  Will
egcs have a problem finding the correct binutils with this option ?
Would --exec-prefix help to solve this, if this is a problem ?

Brendan.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
