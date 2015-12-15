Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 245ED1A0513
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 08:03:58 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Tue, 15 Dec 2015 14:03:56 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 77F42C40004
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 13:52:05 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBFL3s0s24051940
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 14:03:54 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBFL3rmT004400
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 14:03:54 -0700
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH v2 3/6] cxlflash: Removed driver date print
References: <1450126293-47440-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1450127193-48109-1-git-send-email-ukrishn@linux.vnet.ibm.com>
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56708044.4060008@linux.vnet.ibm.com>
Date: Tue, 15 Dec 2015 15:04:04 -0600
MIME-Version: 1.0
In-Reply-To: <1450127193-48109-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/14/2015 3:06 PM, Uma Krishnan wrote:
> Having a date for the driver requires it to be updated quite
> often. Removing the date which is not necessary. Also made
> use of the existing symbol to print the driver name.
>
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
> ---

Acked-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
