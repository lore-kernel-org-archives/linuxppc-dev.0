Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 345E31A1A90
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 08:25:01 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 17 Dec 2015 14:24:56 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A712DC40006
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 14:12:45 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBHLOYPw24313878
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 14:24:34 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBHLOY9l028862
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 14:24:34 -0700
Subject: Re: [PATCH 1/6] cxlflash: Fix to escalate LINK_RESET also on port 1
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
References: <1449787867-23015-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1449788006-23055-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <B3E5E239-FD46-491B-B001-AEA78B913ACC@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Message-ID: <5673281F.9040306@linux.vnet.ibm.com>
Date: Thu, 17 Dec 2015 15:24:47 -0600
MIME-Version: 1.0
In-Reply-To: <B3E5E239-FD46-491B-B001-AEA78B913ACC@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/14/2015 11:30 AM, Matthew R. Ochs wrote:
> Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
>

Reviewed-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
