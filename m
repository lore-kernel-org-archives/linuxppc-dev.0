Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 57B661A0724
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 04:18:39 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Mon, 14 Dec 2015 10:18:34 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 548E71FF004F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 10:06:41 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBEHIUUq29753526
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 10:18:30 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBEHITbD014545
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 10:18:29 -0700
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH 6/6] cxlflash: Enable device id for future IBM CXL adapter
References: <1449787867-23015-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1449788087-23282-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <566E3BEE.9070307@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <566EF9EF.8020800@linux.vnet.ibm.com>
Date: Mon, 14 Dec 2015 11:18:39 -0600
MIME-Version: 1.0
In-Reply-To: <566E3BEE.9070307@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/13/2015 9:47 PM, Andrew Donnellan wrote:
> On 11/12/15 09:54, Uma Krishnan wrote:
>> From: Manoj Kumar <manoj@linux.vnet.ibm.com>
>>
>> This drop enables a future card with a device id
>> of 0x0600 to be recognized by the cxlflash driver.
>> No card specific programming has been added. These
>> card specific changes will be staged in later.
>>
>> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
>
> Without the card-specific code, how does the driver behave if the new
> card is plugged in?

Andrew:

As per the design, the Accelerator Function Unit (AFU)
for this new IBM CXL Flash Adapater retains the same host
interface as the previous generation. For the early prototypes
of the new card, the driver with this change behaves exactly as
the driver prior to this behaved with the earlier generation
card. i.e. No card specific changes are required. However, I
left the staging comment in there, in case later versions of the
card deviate from the prototype.

- Manoj
