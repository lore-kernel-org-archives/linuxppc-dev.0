Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 7C89CDDF9F
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 09:13:39 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id C509014311
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:13:39 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15423-06 for <linuxppc-dev@ozlabs.org>;
	Wed, 24 Oct 2007 01:13:38 +0200 (CEST)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id B87A6142C1
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:13:38 +0200 (CEST)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH 02/11] [POWERPC] Add 'lpb' bus type for MPC5200 LocalPlus Bus
To: linuxppc-dev@ozlabs.org
Date: Wed, 24 Oct 2007 01:13:15 +0200
Message-ID: <20071023231315.29359.87832.stgit@hekate.izotz.org>
In-Reply-To: <20071023231302.29359.27417.stgit@hekate.izotz.org>
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

 arch/powerpc/kernel/of_platform.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index aeaa202..cc33b73 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -49,6 +49,7 @@ static struct of_device_id of_default_bus_ids[] = {
 	{ .type = "plb4", },
 	{ .type = "opb", },
 	{ .type = "ebc", },
+	{ .type = "lpb", },
 	{},
 };
 
