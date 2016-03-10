Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B49721A006D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 11:47:36 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 87660140B0F
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 11:47:36 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 10 Mar 2016 10:47:35 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DA7BC3578053
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 11:47:28 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2A0lK4O62718138
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 11:47:28 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2A0kunJ020491
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 11:46:56 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Matt Ochs <mrochs@us.ibm.com>, Manoj Kumar <kumarmn@us.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v3 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
In-reply-to: <56DFEC78.9050704@linux.vnet.ibm.com>
References: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
 <56DFEC78.9050704@linux.vnet.ibm.com>
Date: Thu, 10 Mar 2016 11:46:01 +1100
Message-Id: <1457570734-sup-641@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Frederic Barrat's message of 2016-03-09 20:27:20 +1100:
> So on afu_read(), we may call afu_driver_ops->event_pending() twice 
> before calling afu_driver_ops->deliver_event(). Actually, in the 
> (likely) scenario where there's only an afu_driver event pending, we 
> *will* call afu_driver_ops->event_pending() twice. Wouldn't it make 
> sense to cache it then?

Yep, will change it.
