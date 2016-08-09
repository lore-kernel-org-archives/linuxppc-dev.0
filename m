Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7s8C1grczDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:12:59 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u79B9EQR021866
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 07:12:57 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24nc23jn7g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 07:12:57 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 9 Aug 2016 12:12:54 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id F1BF62190066
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 12:12:16 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u79BCpmj63176704
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 11:12:51 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u79BCoIJ011929
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 07:12:51 -0400
Subject: Re: [PATCH] cxl: Set psl_fir_cntl to production environment value
To: Michael Ellerman <mpe@ellerman.id.au>, imunsie@au1.ibm.com,
 mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
References: <1470650268-25085-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <87ziomtdq2.fsf@concordia.ellerman.id.au>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 9 Aug 2016 13:12:49 +0200
MIME-Version: 1.0
In-Reply-To: <87ziomtdq2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f63ee25d-2521-3da3-9f0b-efbc27f6b23a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 09/08/2016 à 12:53, Michael Ellerman a écrit :
> Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
>
>> Switch the setting of psl_fir_cntl from debug to production
>> environment recommended value. It mostly affects the PSL behavior when
>> an error is raised in psl_fir1/2.
>>
>> Tested with cxlflash.
>
> Is this a fix you want in rc1, or something for 4.9 ?

rc1 would be great. The cxlflash folks are eagerly waiting for it.

   Fred
