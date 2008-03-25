Return-Path: <york@linux224.somerset.sps.mot.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B0BADDFB4
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 08:27:26 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m2PLRJAu011182
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 14:27:20 -0700 (MST)
Received: from linux224.somerset.sps.mot.com ([163.12.81.191])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m2PLRJiD020737
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 16:27:19 -0500 (CDT)
From: York Sun <yorksun@freescale.com>
To: linux-fbdev-devel@lists.sourceforge.net
Subject: V3 Patch - Driver for Freescale 8610 and 5121 DIU
Date: Tue, 25 Mar 2008 16:27:16 -0500
Message-Id: <120648043867-git-send-email-yorksun@freescale.com>
Cc: a.p.zijlstra@chello.nl, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The following two patches are the 3rd version of the DIU patch for Freescale 8610 and 5121.
It fixed the issues according to the feedback from Andrew Morton.

Andrew, incremental patches are available if requested.

Regards,

York
