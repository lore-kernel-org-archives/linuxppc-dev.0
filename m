Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 396D31A0246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 14:12:05 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 15 Dec 2015 13:12:03 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 742612BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 14:11:58 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBF3Boag53936240
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 14:11:58 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBF3BPUD024625
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 14:11:25 +1100
Subject: Re: [PATCH v2 6/6] cxlflash: Enable device id for future IBM CXL
 adapter
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
References: <1450126293-47440-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1450127263-48261-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@ozlabs.au.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <566F84C4.1000203@au1.ibm.com>
Date: Tue, 15 Dec 2015 14:11:00 +1100
MIME-Version: 1.0
In-Reply-To: <1450127263-48261-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/12/15 08:07, Uma Krishnan wrote:
> From: Manoj Kumar <manoj@linux.vnet.ibm.com>
>
> This drop enables a future card with a device id
> of 0x0600 to be recognized by the cxlflash driver.

If you do a V3 - this could be better worded in the imperative mood as: 
"Add a new device ID (0x0600) for a future IBM CXL Flash Adapter card."

>
> As per the design, the Accelerator Function Unit (AFU)
> for this new IBM CXL Flash Adapter retains the same
> host interface as the previous generation. For the early
> prototypes of the new card, the driver with this change
> behaves exactly as the driver prior to this behaved with
> the earlier generation card. Therefore, no card specific
> programming has been added. These card specific changes
> can be staged in later if needed.
>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

Assuming that the final card won't break in a particularly nasty way in 
the absence of later code changes, all looks good.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
