Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C69EB1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 14:50:51 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9A0681402EC
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2016 14:50:51 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 8 Feb 2016 13:50:50 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DAE4D3578052
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2016 14:50:48 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u181td9u44367978
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Feb 2016 12:55:48 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u183oFHH020555
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Feb 2016 14:50:16 +1100
Date: Mon, 8 Feb 2016 14:49:48 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/eeh: fix incorrect function name in comment
Message-ID: <20160208034948.GA22439@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1454902759-8212-1-git-send-email-andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454902759-8212-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 08, 2016 at 02:39:19PM +1100, Andrew Donnellan wrote:
>The comment block above pcibios_set_pcie_reset_state() incorrectly refers
>to pcibios_set_pcie_slot_reset(). Fix the comment accordingly.
>
>Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
> arch/powerpc/kernel/eeh.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>index 40e4d4a..8c6005c 100644
>--- a/arch/powerpc/kernel/eeh.c
>+++ b/arch/powerpc/kernel/eeh.c
>@@ -739,7 +739,7 @@ static void *eeh_restore_dev_state(void *data, void *userdata)
> }
>
> /**
>- * pcibios_set_pcie_slot_reset - Set PCI-E reset state
>+ * pcibios_set_pcie_reset_state - Set PCI-E reset state
>  * @dev: pci device struct
>  * @state: reset state to enter
>  *
>-- 
>Andrew Donnellan              Software Engineer, OzLabs
>andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
>+61 2 6201 8874 (work)        IBM Australia Limited
>
