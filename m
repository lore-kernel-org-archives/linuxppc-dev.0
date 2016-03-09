Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 515441A004B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 01:20:41 +1100 (AEDT)
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 9 Mar 2016 14:20:37 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2BBD017D8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 14:21:03 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u29EKYQD56164594
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 14:20:34 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u29EKXbF031465
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 07:20:34 -0700
Subject: Re: [v6,12/20] cxl: Add guest-specific code
To: Michael Ellerman <mpe@ellerman.id.au>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <20160309124238.37FD414032B@ozlabs.org>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56E03130.1020309@linux.vnet.ibm.com>
Date: Wed, 9 Mar 2016 15:20:32 +0100
MIME-Version: 1.0
In-Reply-To: <20160309124238.37FD414032B@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 09/03/2016 13:42, Michael Ellerman a écrit :
> I've applied the following patch, let me know if there's anything wrong with
> it. It would be great if we could do something cleaner.


I think this is fine.
I've built pseries_le_defconfig and powernv_defconfig, and did minimum 
of testing with the cxl driver, things look good.

   Fred
