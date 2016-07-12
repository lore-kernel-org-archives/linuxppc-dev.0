Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpPKw1xSszDqpQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 11:20:52 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6C1JN0Y005116
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:20:50 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 242we1ab04-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:20:50 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 12 Jul 2016 11:20:47 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8E2282CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 11:20:44 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6C1Ki6915597674
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 11:20:44 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6C1Ki4C006686
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 11:20:44 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH 14/14] cxl: Add cxl_check_and_switch_mode() API to switch
 bi-modal cards
To: Ian Munsie <imunsie@au1.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-15-git-send-email-imunsie@au.ibm.com>
 <577D533E.4030605@linux.vnet.ibm.com>
 <23e62784-d67a-1e08-ed60-99a50a15b249@au1.ibm.com>
 <1467872513-sup-7704@x230.ozlabs.ibm.com>
 <8ae21f63-a17e-5b57-3a9a-1c38eae358ed@au1.ibm.com>
 <48b96bd7-70fa-3169-ea1f-7ca66b69e41a@au1.ibm.com>
 <1468228528-sup-5354@x230.ozlabs.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, Huy Nguyen
 <huyn@mellanox.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 12 Jul 2016 11:20:43 +1000
MIME-Version: 1.0
In-Reply-To: <1468228528-sup-5354@x230.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <fbc12d2a-21db-ce02-2b6d-67e924244770@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/16 19:19, Ian Munsie wrote:
> I like this solution, but I'm not going to include it in v2 of this
> series and would rather it be submitted separately. The reason being is
> that this series will work as is, and I'd like to see this undergo some
> regression testing separate to the cx4 work, and a bit of scrutiny from
> the hardware team just in case we are missing any device IDs that would
> no longer be matched(I'm not aware of any, but you never know).

Yep, I can send it separately.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
