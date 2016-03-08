Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 914741A009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 09:15:50 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 64F9B140328
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 09:15:50 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 9 Mar 2016 08:15:49 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3C1682BB0055
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 09:15:46 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u28MFbgO9175394
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Mar 2016 09:15:46 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u28MFCvO024698
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Mar 2016 09:15:13 +1100
Date: Wed, 9 Mar 2016 09:14:47 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: powerpc/eeh: eeh_pci_enable(): fix checking of post-request state
Message-ID: <20160308221447.GA4838@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20160208113706.12246140B99@ozlabs.org>
 <56B92B74.8040108@au1.ibm.com> <56DE8280.6020302@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56DE8280.6020302@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 08, 2016 at 06:42:56PM +1100, Andrew Donnellan wrote:
>On 09/02/16 10:57, Andrew Donnellan wrote:
>>It is a fix - I'm a bit hazy on the details now but IIRC, Daniel Axtens
>>and I encountered this when doing some cxl debugging, though I think we
>>decided not to tag this for stable since it was a secondary issue to the
>>primary bug we were looking for. It probably could go to stable though?
>>(Daniel - thoughts?)
>>
>>The line in question was last touched in 4d4f577e4b5e, but it looks like
>>the behaviour wasn't right even before that.
>
>Ping :)
>
>I think this patch should still go in, I don't really care whether it goes to
>stable or not.
>

Andrew, I lost the context about this. If you need any helps like review,
please ping me from IRC.

Thanks,
Gavin

>-- 
>Andrew Donnellan              Software Engineer, OzLabs
>andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
>+61 2 6201 8874 (work)        IBM Australia Limited
