Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mgXB6kmhzF1PT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 15:55:54 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4H5iW6X138771
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 01:55:52 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j0y561rwb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 01:55:51 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Thu, 17 May 2018 06:55:48 +0100
Date: Thu, 17 May 2018 11:25:42 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Stewart Smith <stewart@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, npiggin@gmail.com
Subject: Re: [PATCH] cpuidle/powernv : init all present cpus for deep states
References: <1526472134-23757-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <87efiby6a9.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87efiby6a9.fsf@linux.vnet.ibm.com>
Message-Id: <20180517055542.vvpgw2vy2ivowfdc@aksadiga.ibm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes this needs to be sent to  stable. 

Fixes: d405a98c ("powerpc/powernv: Move cpuidle related code from setup.c
to new file")
