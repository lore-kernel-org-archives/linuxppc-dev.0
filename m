Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ztR11p1JzF13h
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 21:45:16 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w54BdZBO044084
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jun 2018 07:45:14 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jd4r5064b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jun 2018 07:45:13 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Mon, 4 Jun 2018 12:45:11 +0100
Date: Mon, 4 Jun 2018 17:15:00 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>, rjw@rjwysocki.net,
 daniel.lezcano@linaro.org, paulus@samba.org, mpe@ellerman.id.au,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stewart@linux.vnet.ibm.com
Subject: Re: [PATCH v2] cpuidle/powernv : Add Description for cpuidle state
References: <20180604081758.104201-1-huntbag@linux.vnet.ibm.com>
 <0a28154deb468669a59c120a90d4aedc1e1e705b.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0a28154deb468669a59c120a90d4aedc1e1e705b.camel@kernel.crashing.org>
Message-Id: <20180604114500.3rlpuso5aftesnf5@aksadiga.ibm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 04, 2018 at 07:04:14PM +1000, Benjamin Herrenschmidt wrote:
> Is this a new property ? I'm not fan of adding yet another of those
> silly arrays.
> 
> I would say this is the right time now to switch over to a node per
> state instead, as we discussed with Vaidy.

I posted  the node based device tree here :
skiboot patch :  https://patchwork.ozlabs.org/patch/923120/
kernel patch : https://lkml.org/lkml/2018/5/30/1146

Do you have any inputs for this design ?

> 
> Additionally, while doing that, we can provide the versioning mechanism
> I proposed so we can deal with state specific issues and erratas.
> 
> Cheers,
> Ben.
> 
