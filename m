Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDA3F1A0118
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 16:26:10 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 7 Mar 2016 15:26:09 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 59EF42BB005F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 16:26:07 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u275PxGO3080572
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 16:26:07 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u275PYDL004355
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 16:25:35 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: "michael.neuling" <michael.neuling@au1.ibm.com>,
 manoj <manoj@linux.vnet.ibm.com>, mrochs <mrochs@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 20/20] cxl: Remove cxl_get_phys_dev() kernel API
In-reply-to: <1457090804-9719-21-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1457090804-9719-21-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Mon, 07 Mar 2016 16:25:09 +1100
Message-Id: <1457328277-sup-724@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
