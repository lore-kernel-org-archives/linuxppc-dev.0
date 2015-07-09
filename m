Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 177F51A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 11:59:03 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 9 Jul 2015 11:59:02 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E7077357804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 11:58:58 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t691wms730277854
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2015 11:58:56 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t691wQCX026818
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2015 11:58:26 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: Destroy cxl_adapter_idr on module_exit
In-reply-to: <1436368476-30592-1-git-send-email-jthumshirn@suse.de>
References: <1436368476-30592-1-git-send-email-jthumshirn@suse.de>
Date: Thu, 09 Jul 2015 11:58:02 +1000
Message-Id: <1436406813-sup-5637@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>

We are probably also missing an idr_destroy(&afu->contexts_idr); in
cxl_release_afu() as well if you wanted to send a patch for that.

Cheers,
-Ian
