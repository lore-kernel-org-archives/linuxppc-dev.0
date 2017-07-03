Return-Path: <clg@kaod.org>
Received: from 20.mo6.mail-out.ovh.net (20.mo6.mail-out.ovh.net
 [178.32.124.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1Mhy0sbTzDr8s
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 19:46:25 +1000 (AEST)
Received: from player696.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 24C59F4686
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 09:11:31 +0200 (CEST)
Subject: Re: [RFC PATCH 1/2] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <1498123757-18427-1-git-send-email-clg@kaod.org>
 <1498123757-18427-2-git-send-email-clg@kaod.org>
 <20170703035552.GQ13989@umbus.fritz.box>
 <1499055599.16202.23.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <18d0c283-3527-d599-36d8-4397a0a4d6db@kaod.org>
Date: Mon, 3 Jul 2017 09:11:18 +0200
MIME-Version: 1.0
In-Reply-To: <1499055599.16202.23.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2017 06:19 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2017-07-03 at 13:55 +1000, David Gibson wrote:
>>> Calls that still need to be addressed :
>>>
>>>     H_INT_SET_OS_REPORTING_LINE
>>>     H_INT_GET_OS_REPORTING_LINE
>>>     H_INT_ESB
>>>     H_INT_SYNC
>>
>> So, does this mean there's a PAPR update with the XIVE virtualization
>> stuff?  Or at least an ACR?  Can we have that available please...
> 
> There is, I will try to get it published.

Until then, the QEMU support will have some documentation on the 
hcalls and on the device tree.

I am still struggling with CAS on QEMU. POWER9 supports both the 
legacy XICS model and the newer one, XIVE, and we can switch from 
one another depending on the guest kernel. This is a serious 
headache for the model as the ICS/ICP objects are chosen after 
the guest has booted. 

That will be a topic for some discussion on the qemu-ppc mailing 
list. Hopefully soon. 

C.   
