Message-ID: <75DF04AC5ED4D511A9810090273CB4163A67DA@ROKONET-E>
From: Eli Brin <elib@rokonet.co.il>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: ELDK rebuild from scratch on RHL 8.0
Date: Wed, 29 Jan 2003 15:23:10 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

We are trying to build the ELDK from scratch on Redhat Linux 8.0.

The build environment is the same as described in the documentation.

We run the ELDK_BUILD script and it executes the build.sh rpm stage.

It seems that some files are not created and Makefile for rmp-4.0.3 is not
created to.

I have tried also with automake 1.7.2 and autoconf 2.57 with no success.

We found the following text:
....> I had a problem with autogen.sh when compiling TN5250 on RedHat 8.0.
....> (This was 0.17.1 downloaded from CVS.)  It had worked OK on RedHat
7.3.
....>
....> The problem was it didn't copy ltmain.sh to the TN5250 directory,
which
....> caused later fatal errors.  automake versions prior to 1.6 run
....> libtoolize internally to get ltmain.sh.  But in 1.6 they took
libtoolize
....> out of automake and put it in autoreconf, part of autoconf.  (RedHat
7.3
....> has automake 1.4, while 8.0 has 1.6.)
....>
....> The fix was to put libtoolize into autogen.sh just before the call to
....> automake.  Works OK now.

.... I had the same problem with RedHat 8.0, but hadn't had a chance to
chase
.... down the problem yet.  Thanks for posting this!

I don't know if its related to this problem, because the libtoolize is in
the autogen script.

Any ideas ?  I am sure I followed the instructions carefully, but...

Best Regards,
Eli Brin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
