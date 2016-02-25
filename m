Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 568DE1A05AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 12:19:13 +1100 (AEDT)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 25 Feb 2016 06:49:09 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1P1J7AL61931586
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 06:49:08 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1P1J6Gv031626
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 06:49:07 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cxl: Fix PSL timebase synchronization detection
In-Reply-To: <1456334871-30397-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1456334871-30397-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Thu, 25 Feb 2016 06:49:05 +0530
Message-ID: <8737shsi2e.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> The PSL timebase synchronization is seemingly failing for
> configuration not including VIRT_CPU_ACCOUNTING_NATIVE. The driver
> shows the following trace in dmesg:
> PSL: Timebase sync: giving up!
>
> The PSL timebase register is actually syncing correctly, but the cxl
> driver is not detecting it. Fix is to use the proper timebase-to-time
> conversion.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: <stable@vger.kernel.org> # 4.3+

Reviewed-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
