Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 685CD1007D6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2011 03:29:00 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 00/10] powerpc/mpic: General cleanup patch series
Date: Fri,  2 Dec 2011 11:27:57 -0500
Message-Id: <1322843287-2745-1-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <1322795058.3729.48.camel@pasglop>
References: <1322795058.3729.48.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <michaele@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

This is version 3 of the MPIC cleanup patches.

A few minor bugfixes have been rolled into patches 2, 7, and 10, kudos
to Paul Mackerras and Michael Ellerman for reporting them.

Additionally, the series has been rebased onto Ben's "next" branch
for easier merging:
  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next

Unfortunately, my local board-support code conflicts with the mpc85xx
device-tree updates in that branch, so I haven't been able to do more
testing locally.  I will hopefully have that resolved soon, however.

Cheers,
Kyle Moffett
