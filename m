Message-ID: <002001bf8add$8b37aaf0$1dc9a4cd@rtdsp.com>
Reply-To: "Rob Grimm" <rgrimm@rtdsp.com>
From: "Rob Grimm" <rgrimm@rtdsp.com>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.HPX.4.10.10003071044220.22162-100000@gra-ux1.iram.es>
Subject: Cross-compiling Bash
Date: Fri, 10 Mar 2000 17:11:09 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,
    I apologize if this topic has come up before, I checked the archives but
could
not find the answer I'm looking for.

     I have successfully setup a cross-compiler
on an x86 computer, to build code for our embedded PowerPC750 platform.  I
have been able compile the kernel, create a ramdisk, and the kernel boots
fine.
I have been using a small filesystem I downloaded for the mbx board, and can
run the included bash.   My question is, has anyone successfully
cross-compiled
bash (any version, or any GNU software package for that matter)?  Whenever
I run configure (I set all the command line options, like
CC=mycompilername --target=
blah), it says something like can not run test when using cross - compiling.
I get the same results, no matter which GNU package I try to compile (ie
shell-utils).
I have also tried running configure with no options, and then manually
editing
the makefiles so it uses my cross-compiler, this does not work either.
Here is the stuff I am using for my cross-compiler (which has all been built
successfully):
           binutils-2.9.1.0.19a
           egcs-1.1.2
           glibc-2.1.2
           glibc-crypt-2.0.111
           glibc-linuxthreads-2.1.2

Does anyone have any suggestions?  I'm trying to avoid going out and buying
a powermac.  How do others handle this problem, when developing code
on a non-powerpc platform?

    Also, I have tried running pre-built binaries, which I got from
ftp.linuxppc.orq, with
no success.  I downloaded pre-built libs, bash..., and all I get is "init"
on the console
after the kernel boots.  It then hangs up.

Thanks in advance.

Regards,
Rob Grimm

-----------------------------
Rob Grimm
Real-Time Digital
rgrimm@rtdsp.com
-----------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
