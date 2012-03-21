Return-Path: <robert.karl.berger@gmail.com>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C057B6F62
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2012 23:11:08 +1100 (EST)
Received: by eekb57 with SMTP id b57so377068eek.15
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2012 05:11:01 -0700 (PDT)
Message-ID: <4F69C553.6070409@gmail.com>
Date: Wed, 21 Mar 2012 14:10:59 +0200
From: Robert Berger <robert.karl.berger@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: robert.karl.berger@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Up to 3.2.x I was able to compile a mainline kernel for the kilauea
board, but...

http://git.denx.de/?p=linux-denx.git;a=commitdiff;h=075bcf5879225d0c2a119c23d8046b890e051e81

shows, that mfdcrx was introduced in the v3.3 kernel.

The problem is that for ppc-linux-gcc (GCC) 4.2.2 (which comes with the
ELDK 4.2) this assembly instruction is not known and the build breaks.

There are some obvious workarounds, like using a more recent toolchain
(e.g ELDK 5.x) or use make -k to keep on compiling even when there is an
error as much as possible;)

What puzzles me is that also stuff for boards is being compiled which is
not really needed like treeboot-currituck.c even when I configure the
kernel for a kilauea board.

Is this on purpose and if so why?

Please advise.

Regards,

Robert
..."But I have a slowly coagulating theory that the size of a project is
directly proportional to the possibility that significant bugs will crop
up. Exponentiate for each additional programmer involved." - Steven K.
Halliburton

My public pgp key is available at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1
