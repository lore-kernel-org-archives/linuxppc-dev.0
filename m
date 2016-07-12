Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpdwv1JXfzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 20:48:31 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6CAib7X082223
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 06:48:29 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2448qkm192-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 06:48:28 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 12 Jul 2016 20:48:26 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9E3F13578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 20:48:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6CAmNir17170502
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 20:48:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6CAmNhe029954
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 20:48:23 +1000
Subject: Re: [PATCH 08/15] cxl: Add support for using the kernel API with a
 real PHB
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
 <1468237822-26276-9-git-send-email-imunsie@au.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 12 Jul 2016 20:48:22 +1000
MIME-Version: 1.0
In-Reply-To: <1468237822-26276-9-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c90c9c20-2450-1a5d-b611-f0712d0a2c89@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/16 21:50, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> This hooks up support for using the kernel API with a real PHB. After
> the AFU initialisation has completed it calls into the PHB code to pass
> it the AFU that will be used by other peer physical functions on the
> adapter.
>
> The cxl_pci_to_afu API is extended to work with peer PCI devices,
> retrieving the peer AFU from the PHB. This API may also now return an
> error if it is called on a PCI device that is not associated with either
> a cxl vPHB or a peer PCI device to an AFU, and this error is propagated
> down.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
