Return-Path: <jeremy.kerr@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F29601A0201
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 17:47:07 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D0AEA1400B6
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 17:47:07 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <jeremy.kerr@au1.ibm.com>;
 Thu, 13 Nov 2014 16:47:06 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 946FE2CE8064
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 17:47:03 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAD6keMk41943040
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 17:46:48 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAD6kU7K003661
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 17:46:31 +1100
Message-ID: <546453AD.5080909@au1.ibm.com>
Date: Thu, 13 Nov 2014 14:46:05 +0800
From: Jeremy Kerr <jeremy.kerr@au1.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/powernv: Support OPAL requested heartbeat
References: <20141113052937.17DFF1400D2@ozlabs.org>
 <1415860935.666.0.camel@kernel.crashing.org>
In-Reply-To: <1415860935.666.0.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

>> I'd assume "freq" with no units is in HZ, but looks like it's
>> milliseconds. I guess it's too late to rename it.
> 
> We still can, we haven't cut an official build with that fw, jk ?

Not yet. You got in by a matter of minutes :)

Can you send me an updated skiboot patch too then?

Cheers,


Jeremy
