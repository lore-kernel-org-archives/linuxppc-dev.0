Return-Path: <zarniwhoop@ntlworld.com>
Received: from queue03-winn.ispmail.ntl.com (queue03-winn.ispmail.ntl.com
	[81.103.221.57]) by ozlabs.org (Postfix) with ESMTP id EA0C9DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 02:36:28 +1000 (EST)
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
	by mtaout03-winn.ispmail.ntl.com with ESMTP id
	<20070509161729.SQMM16175.mtaout03-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 17:17:29 +0100
Received: from localhost.localdomain ([81.102.242.16])
	by aamtaout04-winn.ispmail.ntl.com with ESMTP id
	<20070509161729.ZKEY29112.aamtaout04-winn.ispmail.ntl.com@localhost.localdomain>
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 17:17:29 +0100
Date: Wed, 9 May 2007 17:17:23 +0100
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: linuxppc-dev@ozlabs.org
Subject: Build failure with Linus' tree
Message-ID: <20070509161723.GA20759@deepthought>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On my G5 I'm getting this on a copy of Linus' tree I pulled a bit
over two hours ago:

  LD      .tmp_vmlinux1
arch/powerpc/sysdev/built-in.o: In function `.iommu_init_late_dart':
dart_iommu.c:(.init.text+0xf10): undefined reference to
`.register_nosave_region_late'
make: *** [.tmp_vmlinux1] Error 1

 I suppose that something is wrong in sysdev/dart_iommu.c, probably
related to suspend changes - if I need to bisect, it will take some
time (this is an SMU powermac, dead slow) so I'll mention it here
now.

Ken
--=20
das eine Mal als Trag=F6die, das andere Mal als Farce
