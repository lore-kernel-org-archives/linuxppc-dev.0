To: crossgcc@cygnus.com
cc: egcs mailing list <egcs@cygnus.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: can't find crt1.o. egcs powerpc-linux cross-compile problem. 
Reply-To: law@cygnus.com
In-reply-to: Your message of Tue, 25 May 1999 09:06:21 -0000.
             <374A680D.8B051E6E@dgs.monash.edu.au>
Date: Tue, 25 May 1999 10:03:18 -0600
Message-ID: <19448.927648198@upchuck.cygnus.com>
From: Jeffrey A Law <law@upchuck.cygnus.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



  In message <374A680D.8B051E6E@dgs.monash.edu.au>you write:
  > 
  > I am trying to compile egcs-1.1.2 as a cross-compiler (linux to
  > powerpc).  I am building on a redhat-5.2 system and have successfully
  > compiled and installed a native egcs-1.12.  I am using this compiler for
  > the cross-compile build and have used the following configure options.
  >     --target=powerpc-linux
  >     --program-prefix=powerpc-linux-
  >     --with-headers=/usr/include
  > 
  > The compilation of xgcc completes.  At some later stage, configure tries
  > to test the newly built xgcc to see if it can build executables, but it
  > fails.  When I run the command manually, the error message says that
  > "ld" can not find crt1.o.  Where is the source for crt1 (egcs or
  > glibc) ?  I can see crt1 files in the newlib tree so my first assumption
  > is that it must be in the glibc tree for linux targets.
  > 
  > Any suggestions to get past my crt1 linking problems.
You have to be able to provide a crt1.o for your target system.  I highly
doubt newlib's crt files are going to be appropriate for a linux target.

  > PS. With regard to the --with-headers option, should I unpack the glibc
  > sources and point --with-headers to the unpacked include directory,
  > instead of the original redhat-5.2 ?
What is most important is that you point to header files that are appropriate
for your target.  ie, if you're sitting on a rh5.2-ix86 system, then
/usr/include is totally useless for a powerpc target.

jeff

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
