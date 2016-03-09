Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BAE4A1A0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 10:36:13 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 10 Mar 2016 09:36:12 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 95A622CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 10:36:09 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u29Na11t1048856
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 10:36:09 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u29NZaeb013692
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 10:35:37 +1100
Subject: Re: [PATCH] cxl: Remove dead code
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
References: <1457524393-6717-1-git-send-email-fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56E0B329.7020304@au1.ibm.com>
Date: Thu, 10 Mar 2016 10:35:05 +1100
MIME-Version: 1.0
In-Reply-To: <1457524393-6717-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/03/16 22:53, Frederic Barrat wrote:
> Function cxl_get_phys_dev() was removed from the kernel API by a
> previous patch, but it's actually dead code. Remove it.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

For those playing along at home, this applies on top of the cxl PowerVM 
series.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
