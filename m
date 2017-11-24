Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yk6Ng1yt6zDrpC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Nov 2017 06:54:58 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAOJrfqd090939
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 14:54:55 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eer7fut91-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 14:54:54 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 24 Nov 2017 19:54:52 -0000
Subject: Re: [PATCH] cxl: Add support for ASB_Notify on POWER9
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: christophe lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Cc: Nick Piggin <npiggin@au1.ibm.com>
Date: Sat, 25 Nov 2017 06:54:48 +1100
In-Reply-To: <d18c47e1-d40f-1d6e-e68c-99ae7be01737@linux.vnet.ibm.com>
References: <1511435132-24020-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1511469668.2466.48.camel@au1.ibm.com>
 <49cd46e7-c13e-c82c-404c-2c9e989b9774@linux.vnet.ibm.com>
 <1511528547.2466.52.camel@au1.ibm.com>
 <d18c47e1-d40f-1d6e-e68c-99ae7be01737@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1511553288.2466.53.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-11-24 at 17:37 +0100, christophe lombard wrote:
> You are right. We will insert a checking in the cxl driver to allow
> updating the TIDR if a P9 is present. This will be in the patch V2.
> Thanks

Best is to actually:

 1) Add something to the device-tree in skiboot (and work with pHyp &
KVM to do the same if not already in ibm,pa-features)

 2) Key off htat.

Nick, anything in your new feature stuff too ?

Ben.
