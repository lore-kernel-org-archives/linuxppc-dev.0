Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0Lkc0mrDzDrQ3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 15:58:15 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6S5naGd062084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 01:58:13 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24dsrrjv7v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 01:58:13 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 28 Jul 2016 15:58:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 141372BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 15:58:09 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6S5w92J27787274
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 15:58:09 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6S5w8Bx003921
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 15:58:08 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Huy Nguyen <huyn@mellanox.com>,
 fbarrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cxl: fix NULL dereference in cxl_context_init() on
 PowerVM guests
In-reply-to: <1469684381-22354-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1469684381-22354-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Thu, 28 Jul 2016 15:58:06 +1000
Message-Id: <1469685394-sup-7123@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Whoops!

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
