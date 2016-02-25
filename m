Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 210471A088A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 11:31:22 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 25 Feb 2016 10:31:20 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5CEE32CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 11:31:18 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1P0VAPG46989340
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 11:31:18 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1P0UjnJ025631
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 11:30:46 +1100
Subject: Re: [PATCH] cxl: Fix PSL timebase synchronization detection
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <1456334871-30397-1-git-send-email-fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56CE4B1D.6080500@au1.ibm.com>
Date: Thu, 25 Feb 2016 11:30:21 +1100
MIME-Version: 1.0
In-Reply-To: <1456334871-30397-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25/02/16 04:27, Frederic Barrat wrote:
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

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
