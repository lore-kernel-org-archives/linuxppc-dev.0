Return-Path: <jkenisto@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0171B70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 15:54:21 +1100 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAC4sj0j031807
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 23:54:45 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAC4rnuX360342
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 23:53:49 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAC4rmYv009905
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 23:53:48 -0500
Received: from localhost.localdomain (w-jimk.beaverton.ibm.com [9.47.28.66])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	oAC4rmIb009896
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 23:53:48 -0500
From: Jim Keniston <jkenisto@us.ibm.com>
Subject: [PATCH 0/4] More ppc64 nvram code cleanup
To: linuxppc-dev@lists.ozlabs.org
Date: Thu, 11 Nov 2010 20:53:48 -0800
Message-ID: <20101112045346.4290.43739.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series contains some fixups to Ben Herrenschmidt's Aug. 2 patch
set, "[RFC] Clean up ppc64 nvram code" --
http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-August/084601.html

These patches apply atop Ben's 11-patch series.
---

Jim Keniston (4):
      Handle partition names >= 12 chars
      Fix NVRAM partition list setup
      Fix nvram_create_partition() arg order
      Fix powerpc nvram init order


 arch/powerpc/kernel/nvram_64.c         |   31 +++++++++++--------------------
 arch/powerpc/platforms/pseries/nvram.c |    8 ++++----
 2 files changed, 15 insertions(+), 24 deletions(-)

--
Jim Keniston
IBM Linux Technology Center
Beaverton, OR
