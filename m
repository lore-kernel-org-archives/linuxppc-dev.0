Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp00j1gLDzDqxS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 19:19:31 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6B9IpDf059755
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 05:19:29 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 242we0cgs9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 05:19:29 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 11 Jul 2016 19:19:26 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 375502BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 19:19:24 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6B9JOh725100522
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 19:19:24 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6B9JNDb011219
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 19:19:23 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 14/14] cxl: Add cxl_check_and_switch_mode() API to switch
 bi-modal cards
In-reply-to: <48b96bd7-70fa-3169-ea1f-7ca66b69e41a@au1.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-15-git-send-email-imunsie@au.ibm.com>
 <577D533E.4030605@linux.vnet.ibm.com>
 <23e62784-d67a-1e08-ed60-99a50a15b249@au1.ibm.com>
 <1467872513-sup-7704@x230.ozlabs.ibm.com>
 <8ae21f63-a17e-5b57-3a9a-1c38eae358ed@au1.ibm.com>
 <48b96bd7-70fa-3169-ea1f-7ca66b69e41a@au1.ibm.com>
Date: Mon, 11 Jul 2016 19:19:22 +1000
Message-Id: <1468228528-sup-5354@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from andrew.donnellan's message of 2016-07-07 18:15:06 +1000:
> On 07/07/16 16:44, Andrew Donnellan wrote:
> > We can match the vendor, device ID *and* class code - unfortunately
> > there isn't a macro for this, which makes it a little bit less
> > aesthetically pleasing, but I'm pretty sure this works.
> 
> Something like the below, which works fine:

I like this solution, but I'm not going to include it in v2 of this
series and would rather it be submitted separately. The reason being is
that this series will work as is, and I'd like to see this undergo some
regression testing separate to the cx4 work, and a bit of scrutiny from
the hardware team just in case we are missing any device IDs that would
no longer be matched(I'm not aware of any, but you never know).

Cheers,
-Ian
