Return-Path: <dvhltc@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5DEEF1007D1
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 14:28:54 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o754HMqL000866
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 22:17:22 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o754SpEm134592
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 22:28:51 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o754WF1O003375
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 22:32:15 -0600
From: Darren Hart <dvhltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] powerpc: cpu offline/online fixes for CONFIG_PREEMPT
Date: Wed,  4 Aug 2010 21:28:32 -0700
Message-Id: <1280982515-18231-1-git-send-email-dvhltc@us.ibm.com>
Cc: dvhltc@us.ibm.com, brking@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	will_schmidt@vnet.ibm.com, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patch series addresses several issues detected during intense CPU
offline/online testing on the mainline kernel with CONFIG_PREEMPT=y. These
patches require the following patch from Brian King:

http://patchwork.ozlabs.org/patch/59645/

Tested against linux-2.6.git master with and without CONFIG_DEBUG_PREEMPT.
