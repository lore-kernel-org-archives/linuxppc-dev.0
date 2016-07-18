Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtGL20V3HzDqHC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 18:19:21 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6I8If1k029303
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 04:19:20 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24826ye209-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 04:19:19 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 18 Jul 2016 18:19:17 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D370B2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 18:19:13 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6I8JDVk22151410
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 18:19:13 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6I8JDRC019038
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 18:19:13 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 ukrishn <ukrishn@linux.vnet.ibm.com>, fbarrat <fbarrat@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 clombard <clombard@linux.vnet.ibm.com>,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: Re: [PATCH] cxl: add option to enable -DDEBUG
In-reply-to: <1468829857-821-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1468829857-821-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Mon, 18 Jul 2016 18:19:11 +1000
Message-Id: <1468829918-sup-4781@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
