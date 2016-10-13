Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svpzx5sRfzDsyh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 22:54:21 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9DBrmRk011902
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 07:54:19 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2625dqw8yg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 07:54:19 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 13 Oct 2016 12:54:17 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id A99F817D805A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 12:56:23 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9DBsEAI23134226
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 11:54:14 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9DBsEVG008092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 05:54:14 -0600
Subject: Re: [PATCH] powerpc/mm: Prevent unlikely crash in
 copro_calculate_slb()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <1466182408-17884-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <3e856f04-23a7-b980-a857-27b3342f1548@linux.vnet.ibm.com>
 <87h98ged3y.fsf@concordia.ellerman.id.au>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 13 Oct 2016 13:54:14 +0200
MIME-Version: 1.0
In-Reply-To: <87h98ged3y.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <ee67bc79-b620-162e-811f-dccce02ce7bc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 13/10/2016 à 12:51, Michael Ellerman a écrit :
> Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
>
>> ping? The patch still applies cleanly on recent trees.
>
> Fell through the cracks :/
>
> Fixes: ?

Nothing obvious. Current code was introduced by 
73d16a6e0e51990cbe13f8d8f43bd5329bbab30a
but it was apparently moved from cell, where the issue may not have 
applied, I don't know. I guess we should use that id if really needed:

Fixes: 73d16a6e0e51 ("powerpc/cell: Move data segment faulting code out 
of cell platform")

   Fred
