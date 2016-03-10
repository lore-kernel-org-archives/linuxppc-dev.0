Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51DC51A005D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 12:27:25 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 161D91402A8
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 12:27:24 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 10 Mar 2016 11:27:23 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 325CB2CE8056
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 12:27:22 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2A1RDeu13828158
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 12:27:22 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2A1QnjM017683
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 12:26:49 +1100
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
Date: Thu, 10 Mar 2016 12:26:22 +1100
Message-Id: <1457573125-sup-1934@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Frederic Barrat's message of 2016-03-09 20:27:20 +1100:
> It would also avoid entering
>         WARN(1, "afu_read must be buggy\n");
> if the driver changes its mind between the 2 calls :-)

Honestly, it had better not - that would be a gross violation of the
poll & read semantics and the kind of thing that leads to application
hangs.

Cheers,
-Ian
