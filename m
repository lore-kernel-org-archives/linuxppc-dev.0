Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 504AA1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 22:35:14 +1100 (AEDT)
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 9 Mar 2016 11:35:10 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id ECB2F219005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 11:34:49 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u29BZ6kI3998148
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 11:35:06 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u29BZ4HE030386
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 04:35:06 -0700
Subject: Re: [v6,20/20] cxl: Remove cxl_get_phys_dev() kernel API
To: Michael Ellerman <mpe@ellerman.id.au>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <20160309110945.44E2E140328@ozlabs.org>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56E00A66.3010304@linux.vnet.ibm.com>
Date: Wed, 9 Mar 2016 12:35:02 +0100
MIME-Version: 1.0
In-Reply-To: <20160309110945.44E2E140328@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 09/03/2016 12:09, Michael Ellerman a écrit :
> This appears to make cxl_get_phys_dev() completely unused, doesn't it?
>
> If so, please send me a follow-up patch to remove it entirely.


I would have sworn there was one internal call to it, but I was confused 
by some older version.

Follow-up patch on the way.

   Fred
