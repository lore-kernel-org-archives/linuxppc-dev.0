Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FB531A0038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 16:02:31 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 34BD5140D26
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 16:02:31 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 30 Sep 2015 16:02:30 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D75AB2CE8050
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 16:02:27 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8U62K9m43253906
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 16:02:29 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8U61smh006291
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 16:01:55 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, mikey <mikey@neuling.org>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] cxl: fix leak of ctx->irq_bitmap when releasing
 context via kernel API
In-reply-to: <1443578287-7847-2-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1443578287-7847-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1443578287-7847-2-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Wed, 30 Sep 2015 16:01:29 +1000
Message-Id: <1443592883-sup-3450@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
