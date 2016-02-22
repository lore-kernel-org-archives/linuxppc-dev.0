Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46D901A08FC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 05:15:00 +1100 (AEDT)
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 18:14:58 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7F8E517D8042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 18:15:15 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1MIEsu032178188
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 18:14:54 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1MHEtSs018981
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 10:14:55 -0700
Subject: Re: Fwd: [PATCH v4 10/18] cxl: New hcalls to support CAPI adapters
To: manoj@linux.vnet.ibm.com
References: <1455658751-16970-11-git-send-email-fbarrat@linux.vnet.ibm.com>
 <56CA2CC6.9010802@linux.vnet.ibm.com> <56CA46A6.3070005@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>, michael.neuling@au1.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56CB501C.4020906@linux.vnet.ibm.com>
Date: Mon, 22 Feb 2016 19:14:52 +0100
MIME-Version: 1.0
In-Reply-To: <56CA46A6.3070005@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>> +
>> +/**
>> + * cxl_h_validate_adapter_image - Validate the base image in the
>> coherent
>> + *                                platoform facility.
>
> platoform->platform
>
> Irreverent to the Socratic amongst us.


Hope we didn't hurt your feelings :-D

   Fred
