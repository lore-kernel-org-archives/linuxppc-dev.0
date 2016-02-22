Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 614351A0356
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 05:13:49 +1100 (AEDT)
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 18:13:45 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 14EEA17D8042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 18:14:04 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1MIDhCx1835410
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 18:13:43 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1MHDiOE017394
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 10:13:44 -0700
Subject: Re: Fwd: [PATCH v4 02/18] cxl: Move bare-metal specific code to
 specialized files
To: manoj@linux.vnet.ibm.com
References: <1455658751-16970-3-git-send-email-fbarrat@linux.vnet.ibm.com>
 <56CA2C7C.40803@linux.vnet.ibm.com> <56CA2FA2.40404@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>, michael.neuling1@au1.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56CB4FD5.40501@linux.vnet.ibm.com>
Date: Mon, 22 Feb 2016 19:13:41 +0100
MIME-Version: 1.0
In-Reply-To: <56CA2FA2.40404@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 21/02/2016 22:44, Manoj Kumar a écrit :
>> Code specific to bare-metal is meant to be in native.c or pci.c
>> only. It's basically anything which touches the capi p1 registers,
>
> I thought we were going to avoid using the CAPI term externally.
> Please update if submitting a v4 of this patch series.

True, cxl should be preferred. I've renamed most of them for v5, just 
letting a couple in patch 0 since it doesn't stay and when I believed 
the context required it.

   Fred
