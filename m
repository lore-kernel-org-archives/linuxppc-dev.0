Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1BB81A01B2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 06:29:58 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 14 Dec 2015 12:29:55 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0CE071FF0050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 12:17:58 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBEJTl4229819096
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 12:29:47 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBEJTkX6026805
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 12:29:46 -0700
Subject: Re: [PATCH 3/6] cxlflash: Updated date of the driver
To: Daniel Axtens <dja@axtens.net>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
References: <1449787867-23015-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1449788043-23131-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <87d1udkejd.fsf@gamma.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Message-ID: <566F18B3.6040907@linux.vnet.ibm.com>
Date: Mon, 14 Dec 2015 13:29:55 -0600
MIME-Version: 1.0
In-Reply-To: <87d1udkejd.fsf@gamma.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/10/2015 6:35 PM, Daniel Axtens wrote:
> Hi Uma,
>
> It looks like CXLFLASH_DRIVER_DATE is only used once, on init, and it's
> just printed. Is it necessary? It looks like having it will require
> sending a patch to update it quite often.
>

Hi Daniel,

Valid point. I will pull this out from the code. This should be included
in the second version of the patch series.

Thanks,
Uma Krishnan
