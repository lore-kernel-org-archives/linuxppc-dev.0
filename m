Return-Path: <josejx@gentoo.org>
Received: from alnrmhc11.comcast.net (alnrmhc13.comcast.net [204.127.225.93])
	by ozlabs.org (Postfix) with ESMTP id 242FB67B7E
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Sep 2006 06:53:43 +1000 (EST)
Message-ID: <45032775.4080000@gentoo.org>
Date: Sat, 09 Sep 2006 16:43:33 -0400
From: Joseph Jezak <josejx@gentoo.org>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: highmem.h
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everyone,

I think highmem.h needs to be copied from include/asm-ppc to
include/asm-powerpc.  For instance, if you include linux/skbuff.h,
it includes linux/highmem.h.  If CONFIG_HIGHMEM is enabled (which is
possible on PPC32), then linux/highmem.h includes asm/highmem.h
which isn't currently included in include/asm-powerpc.

Am I overlooking something here?  For what it's worth, I noticed
this while building the sheep module in MOL.

-Joe
