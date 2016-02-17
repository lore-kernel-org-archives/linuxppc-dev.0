Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39D331A2E6C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 15:39:33 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 17 Feb 2016 14:39:32 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B7DDD3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 15:39:29 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1H4dLij9568588
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 15:39:29 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1H4cuBF004017
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 15:38:57 +1100
Subject: Re: [PATCH v8 04/45] powerpc/powernv: Cleanup on pci_controller_ops
 instances
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-5-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: devicetree@vger.kernel.org, aik@ozlabs.ru, linux-pci@vger.kernel.org,
 grant.likely@linaro.org, robherring2@gmail.com, bhelgaas@google.com,
 dja@axtens.net
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56C3F948.5090804@au1.ibm.com>
Date: Wed, 17 Feb 2016 15:38:32 +1100
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-5-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17/02/16 14:43, Gavin Shan wrote:
> This cleans up on below data struct instances to use tab instead of
> space indent of statement to avoid complains from scripts/checkpatch.pl.
> No logical changes introduced.
>
>    @pnv_pci_ioda_controller_ops
>    @pnv_npu_ioda_controller_ops
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
