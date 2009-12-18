Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 510AFB6F12
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Dec 2009 01:08:48 +1100 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBIE3VeN024346
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2009 09:03:31 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBIE8iEG102934
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2009 09:08:44 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBIE8iFZ029303
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2009 12:08:44 -0200
Date: Fri, 18 Dec 2009 09:08:40 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20091218140840.GH8458@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

A couple more small commits for .33 below.

I'd like to get the 460SX patch in still, but it's not quite ready.  I also plan
on doing some defconfig updates around -rc2.  Other than that, I don't have
any outstanding patches other than those below.

thx,
josh

The following changes since commit e090aa80321b64c3b793f3b047e31ecf1af9538d:
  Benjamin Herrenschmidt (1):
        powerpc: Fix usage of 64-bit instruction in 32-bit altivec code

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Anatolij Gustschin (1):
      powerpc/44x: Extend Katmai dts for ADMA and RAID56 support

Sean MacLennan (1):
      powerpc/44x: Increase warp SD buffer

 arch/powerpc/boot/dts/katmai.dts |   52 +++++++++++++++++++++++++++++++++++++-
 arch/powerpc/boot/dts/warp.dts   |    2 +-
 2 files changed, 52 insertions(+), 2 deletions(-)
