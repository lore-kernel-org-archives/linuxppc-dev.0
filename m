Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJS615jGTzDvr9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 12:56:09 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAG1rlCk061604
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 20:56:08 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26r4c57nx7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 20:56:07 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 16 Nov 2016 11:56:05 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 906AC2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 12:56:02 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAG1u2Gp52428976
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 12:56:02 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAG1u2PT020843
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 12:56:02 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: fbarrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 kernel-janitors <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] cxl: Fix error handling
In-reply-to: <20161030214047.25037-1-christophe.jaillet@wanadoo.fr>
References: <20161030214047.25037-1-christophe.jaillet@wanadoo.fr>
Date: Wed, 16 Nov 2016 12:56:00 +1100
Message-Id: <1479261352-sup-2637@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
