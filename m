Message-ID: <3F29ED34.5080304@kegel.com>
Date: Thu, 31 Jul 2003 21:31:48 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: crosstool-0.16: ppc405 working in glibc-2.3.2 now
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


crosstool is a set of scripts for building and testing cross-compilers
based on gcc/glibc/linux.

A new release is ready, and can be downloaded from
      http://kegel.com/crosstool

The big change with this release is that it builds glibc-2.3.2
properly on ppc405, thanks to a patch from Daniel Jacobowitz.
You can see the regression test summaries at
      http://www.kegel.com/crosstool/current/summaries/

Changelog:

0.16 21 July 2003 "Shaking out glibc-2.3.2 a bit"

      glibc-2.3.2-patches/glibc-2.3.2-without-fp.patch, straight from Daniel
      Jacobowitz, fixes the --without-fp option of glibc-2.3.2, needed for ppc405.

      glibc-2.3.2-patches/glibc-2.3.2-cross.patch, from cvs, avoids a glaring build failure.

      gcc-3.3-patches/sh-pic-set_fpscr.patch is a partial fix for problems
      building gcc-3.3/glibc-2.3.2 for sh4.  Work in progress.

      gcc3.3-glibc2.3.2.dat now refers to binutils-2.14.90.0.5 in hopes
      that fixes problems on sh4 (or at least makes it easier for Kaz to
      play with)

      My gcc-*-patches directories are a bit out of sync; if you run
      into a problem, it could be the patch you need hasn't been copied
      or symlinked into your version of gcc's patches directory yet.

      Note that wget on Red Hat 9 is rumored to not be able to fetch from
      gnu.org.  Workaround - use vanilla wget, or perhaps add the flag to use
      passive mode.


--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
