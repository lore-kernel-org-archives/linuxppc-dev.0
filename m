Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryQXj4bCszDqWT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 12:43:01 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6P2d5Fk030272
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 22:42:58 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24c1h3ettw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 22:42:58 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 25 Jul 2016 12:42:54 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 273113578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 12:42:52 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6P2gpFG30408822
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 12:42:52 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6P2gpYp021053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 12:42:51 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 fbarrat <fbarrat@linux.vnet.ibm.com>,
 clombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH] cxl: fix sparse warnings
In-reply-to: <1469178096-8510-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1469178096-8510-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Mon, 25 Jul 2016 12:42:48 +1000
Message-Id: <1469414562-sup-3783@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
