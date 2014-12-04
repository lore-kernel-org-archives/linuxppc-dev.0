Return-Path: <dborkman@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B11751A0064
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 00:41:49 +1100 (AEDT)
Message-ID: <54806490.6080303@redhat.com>
Date: Thu, 04 Dec 2014 14:41:36 +0100
From: Daniel Borkmann <dborkman@redhat.com>
MIME-Version: 1.0
To: Caz.Yokoyama@intel.com
Subject: ppc64 and Documentation/mic/mpssd/mpssd.c issues
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Caz,

I think commit ...

commit 8d49751580db804a02caf6a5b7cebe2ff26c0d7e
Author: Caz Yokoyama <Caz.Yokoyama@intel.com>
Date:   Thu Sep 5 16:42:39 2013 -0700

     Sample Implementation of Intel MIC User Space Daemon.

... actually triggers a build error on my default config
ppc64 (I'm using net-next tree):

   HOSTCC  Documentation/mic/mpssd/mpssd.o
Documentation/mic/mpssd/mpssd.c:93: error: braced-group within expression allowed only inside a function
Documentation/mic/mpssd/mpssd.c:96: error: braced-group within expression allowed only inside a function
Documentation/mic/mpssd/mpssd.c:113: error: braced-group within expression allowed only inside a function
Documentation/mic/mpssd/mpssd.c:116: error: braced-group within expression allowed only inside a function
Documentation/mic/mpssd/mpssd.c:119: error: braced-group within expression allowed only inside a function
Documentation/mic/mpssd/mpssd.c:146: error: braced-group within expression allowed only inside a function
Documentation/mic/mpssd/mpssd.c:149: error: braced-group within expression allowed only inside a function
Documentation/mic/mpssd/mpssd.c:151: error: braced-group within expression allowed only inside a function
Documentation/mic/mpssd/mpssd.c:152: error: braced-group within expression allowed only inside a function
make[3]: *** [Documentation/mic/mpssd/mpssd.o] Error 1
make[2]: *** [Documentation/mic/mpssd] Error 2
make[1]: *** [Documentation/mic] Error 2
make: *** [vmlinux] Error 2

gcc --version
gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-11)

Cheers,
Daniel
