Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFnkk2WzCzDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 12:59:58 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7J2wjUS069583
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 22:59:55 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24wg7futjq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 22:59:55 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 19 Aug 2016 12:59:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 322DA3578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 12:59:49 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7J2xnvB25231492
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 12:59:49 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7J2xmFQ006954
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 12:59:48 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 clombard <clombard@linux.vnet.ibm.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 gwshan <gwshan@linux.vnet.ibm.com>, fbarrat <fbarrat@linux.vnet.ibm.com>,
 mauricfo <mauricfo@linux.vnet.ibm.com>, helgaas <helgaas@kernel.org>,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 ukrishn <ukrishn@linux.vnet.ibm.com>
Subject: Re: [PATCH] cxl: use pcibios_free_controller_deferred() when removing
 vPHBs
In-reply-to: <1471505714-30049-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1471505714-30049-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Fri, 19 Aug 2016 12:59:17 +1000
Message-Id: <1471575548-sup-5761@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
