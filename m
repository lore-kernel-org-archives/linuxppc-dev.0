Return-Path: <Varun.Sethi@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10B541A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 07:15:06 +1000 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <alex.williamson@redhat.com>
Subject: [PATCH 2/3] iommu/fsl: Fix the device domain attach condition.
Date: Tue, 24 Jun 2014 19:27:16 +0530
Message-ID: <1403618237-26248-3-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

