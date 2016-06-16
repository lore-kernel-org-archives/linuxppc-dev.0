Return-Path: <felix@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVlMb20B2zDqr8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 23:58:03 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5GDs87h024166
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 09:58:00 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23kqt2688j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 09:58:00 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Thu, 16 Jun 2016 14:57:58 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id D8085219004D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 14:57:26 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5GDvtEa7471384
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 13:57:55 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5GDvsGi023006
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 07:57:55 -0600
Date: Thu, 16 Jun 2016 15:59:15 +0200
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 mrochs@linux.vnet.ibm.com, manoj@linux.vnet.ibm.com, imunsie@au1.ibm.com
Subject: Re: [v5, 1/2] cxl: Add mechanism for delivering AFU driver specific
 events
References: <3rVkCP66Gbz9t0G@ozlabs.org>
In-Reply-To: <3rVkCP66Gbz9t0G@ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Message-Id: <5762B0B3.5030902@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Mon, 2016-23-05 at 12:49:01 UTC, Philippe Bergheaud wrote:
> 
>>This adds an afu_driver_ops structure with deliver_event() and
>>event_delivered() callbacks. An AFU driver such as cxlflash can fill
>>this out and associate it with a context to enable passing custom
>>AFU specific events to userspace.
>>
>>This also adds a new kernel API function cxl_context_pending_events(),
>>that the AFU driver can use to notify the cxl driver that new specific
>>events are ready to be delivered, and wake up anyone waiting on the
>>context wait queue.
> 
> ...
> 
>>Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> 
> 
> It looks like the discussion has settled down on this one, and everyone was OK
> with it, except maybe the naming?
> 
> So can we either get some ACKs, or a v6 with new naming?
> 
I am about to send a v6.

Philippe
