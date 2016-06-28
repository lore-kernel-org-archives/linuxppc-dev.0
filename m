Return-Path: <felix@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf0gW1kDLzDqnP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 19:21:59 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5S9JQa8039023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 05:21:56 -0400
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23sm3usrvf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 05:21:54 -0400
Received: from localhost
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 10:21:52 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 21B2517D805D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 10:23:08 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5S9LmlY17367510
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 09:21:48 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5S9Ll6V024085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 03:21:48 -0600
Date: Tue, 28 Jun 2016 11:24:03 +0200
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 mrochs@linux.vnet.ibm.com, imunsie@au1.ibm.com, manoj@linux.vnet.ibm.com
Subject: Re: [RESEND, v7, 2/2] cxl: Add set and get private data to context
 struct
References: <3rdzYL1XJgz9sCg@ozlabs.org>
In-Reply-To: <3rdzYL1XJgz9sCg@ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Message-Id: <57724233.50709@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Fri, 2016-24-06 at 06:47:07 UTC, Philippe Bergheaud wrote:
> 
>>From: Michael Neuling <mikey@neuling.org>
>>
>>This provides AFU drivers a means to associate private data with a cxl
>>context. This is particularly intended for make the new callbacks for
>>driver specific events easier for AFU drivers to use, as they can easily
>>get back to any private data structures they may use.
>>
>>Signed-off-by: Michael Neuling <mikey@neuling.org>
>>Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
>>Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com
>>Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
>>Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>>---
>>No changes since v1. Added Matt Ochs reviewed-by tag.
> 
> 
> I'm not sure why this is RESEND ?
> 
Sorry. That was because I made a typo in the title (I typed v6 instead of v7).
> Does this pair with [v7 1/2] ?
> 
Yes it does.
>   https://patchwork.ozlabs.org/patch/639644/
> 
> It's a lot simpler if you just resend the whole series each time there is an
> update to any patch.
> 
Got it, thank you.

Philippe
