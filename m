Message-Id: <4.2.0.25.19990311162952.03ed2b80@mail.lauterbach.com>
Date: Thu, 11 Mar 1999 16:37:18 +0100
To: "F. Heitkamp" <fheitka@ibm.net>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: binutils-2.9.1.0.22b
Cc: linuxppc-dev@lists.linuxppc.org, hjl@varesearch.com (H.J. Lu)
In-Reply-To: <199903111219.HAA13676@pc1.fred.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hmm, are you sure you did everything right during configure/make? I have no 
problems with 22b on glibc-2.1 (R5) here. Just the usual ld testsuite FAILs:

FAIL: bootstrap
FAIL: bootstrap with --static
FAIL: bootstrap with --traditional-format
FAIL: bootstrap with --no-keep-memory
FAIL: cdtest
FAIL: cdtest with -Ur

And with 19a there are problems with strip, which sometimes seems to 
corrupt binaries. I have to investigate this with 22b yet.

Franz.

At 13:19 11.03.99 , F. Heitkamp wrote:


>This binutils seems to have some problems.
>Is there any patches, fixes, or web site with more information?
>
>Thanks!
>
>make[1]: Entering directory `/usr/src/binutils-build/bfd'
>Making check in doc
>make[2]: Entering directory `/usr/src/binutils-build/bfd/doc'
>make
>make[3]: Entering directory `/usr/src/binutils-build/bfd/doc'
>make[3]: Nothing to be done for `all'.
>make[3]: Leaving directory `/usr/src/binutils-build/bfd/doc'
>make[2]: Leaving directory `/usr/src/binutils-build/bfd/doc'
>make[2]: Entering directory `/usr/src/binutils-build/bfd'
>make[2]: Nothing to be done for `check-am'.
>make[2]: Leaving directory `/usr/src/binutils-build/bfd'
>make[1]: Leaving directory `/usr/src/binutils-build/bfd'
>make[1]: Entering directory `/usr/src/binutils-build/binutils'
>make  check-DEJAGNU
>make[2]: Entering directory `/usr/src/binutils-build/binutils'
>srcdir=`cd ../../binutils-2.9.1.0.22b/binutils && pwd`; export srcdir; \
>r=`pwd`; export r; \
>EXPECT=expect; export EXPECT; \
>if [ -f ./../expect/expect ]; then \
>  TCL_LIBRARY=`cd ../../binutils-2.9.1.0.22b/binutils/../tcl/library && 
> pwd`; \
>  export TCL_LIBRARY; \
>fi; \
>runtest=runtest; \
>if /bin/sh -c "$runtest --version" > /dev/null 2>&1; then \
>  $runtest --tool binutils --srcdir ${srcdir}/testsuite \
>        CC_FOR_TARGET="gcc" \
>        CFLAGS_FOR_TARGET="-g -O2" ; \
>else echo "WARNING: could not find \`runtest'" 1>&2; :;\
>fi
>WARNING: Couldn't find the global config file.
>WARNING: Couldn't find tool init file
>Test Run By heitkamp on Wed Mar 10 11:19:13 1999
>Native configuration is powerpc-unknown-linux-gnu
>
>                === binutils tests ===
>
>Schedule of variations:
>    unix
>
>Running target unix
>Using /usr/local/share/dejagnu/baseboards/unix.exp as board description 
>file for target.
>Using /usr/local/share/dejagnu/config/unix.exp as generic interface file 
>for target.
>Using /usr/src/binutils-2.9.1.0.22b/binutils/testsuite/config/default.exp 
>as tool-and-target-specific interface file.
>Running 
>/usr/src/binutils-2.9.1.0.22b/binutils/testsuite/binutils-all/ar.exp ...
>FAIL: ar long file names
>ERROR: 
>/usr/src/binutils-2.9.1.0.22b/binutils/testsuite/binutils-all/bintest.s: 
>assembly failed
>Running 
>/usr/src/binutils-2.9.1.0.22b/binutils/testsuite/binutils-all/hppa/objdump. 
>exp ...
>Running 
>/usr/src/binutils-2.9.1.0.22b/binutils/testsuite/binutils-all/nm.exp ...
>Version /usr/src/binutils-build/binutils/nm-new failed
>ERROR: 
>/usr/src/binutils-2.9.1.0.22b/binutils/testsuite/binutils-all/bintest.s: 
>assembly failed
>Running 
>/usr/src/binutils-2.9.1.0.22b/binutils/testsuite/binutils-all/objcopy.exp ...
>Version /usr/src/binutils-build/binutils/objcopy failed
>ERROR: 
>/usr/src/binutils-2.9.1.0.22b/binutils/testsuite/binutils-all/bintest.s: 
>assembly failed
>Running 
>/usr/src/binutils-2.9.1.0.22b/binutils/testsuite/binutils-all/objdump.exp ...
>Version /usr/src/binutils-build/binutils/objdump failed
>FAIL: objdump -i
>ERROR: 
>/usr/src/binutils-2.9.1.0.22b/binutils/testsuite/binutils-all/bintest.s: 
>assembly failed
>Running 
>/usr/src/binutils-2.9.1.0.22b/binutils/testsuite/binutils-all/size.exp ...
>Version /usr/src/binutils-build/binutils/size failed
>ERROR: 
>/usr/src/binutils-2.9.1.0.22b/binutils/testsuite/binutils-all/bintest.s: 
>assembly failed
>
>                === binutils Summary ===
>
># of unexpected failures        2
># of unresolved testcases       2
>make[2]: *** [check-DEJAGNU] Error 1
>make[2]: Leaving directory `/usr/src/binutils-build/binutils'
>make[1]: *** [check-am] Error 2
>make[1]: Leaving directory `/usr/src/binutils-build/binutils'
>make: *** [check-binutils] Error 2


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
