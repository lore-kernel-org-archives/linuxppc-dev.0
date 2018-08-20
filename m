Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vM5G4xwbzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 03:59:30 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7KHx6dW019191
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 13:59:27 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m010vkmhf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 13:59:27 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Mon, 20 Aug 2018 18:59:24 +0100
Date: Mon, 20 Aug 2018 10:59:18 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] powerpc: Detect the presence of big-cores via
 "ibm,thread-groups"
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1534743704-4760-1-git-send-email-ego@linux.vnet.ibm.com>
 <1534743704-4760-2-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1534743704-4760-2-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <20180820175918.GA23117@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2018-08-20 11:11:43]:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> On IBM POWER9, the device tree exposes a property array identifed by
one small nit:
s/identifed/identified/g

> "ibm,thread-groups" which will indicate which groups of threads share
> a particular set of resources.
> 
> As of today we only have one form of grouping identifying the group of
> threads in the core that share the L1 cache, translation cache and
> instruction data flow.
> 
> This patch defines the helper function to parse the contents of
> "ibm,thread-groups" and a new structure to contain the parsed output.
> 
> The patch also creates the sysfs file named "small_core_siblings" that
> returns the physical ids of the threads in the core that share the L1
> cache, translation cache and instruction data flow.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Otherwise looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
