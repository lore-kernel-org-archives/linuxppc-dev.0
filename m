Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1CAB1A1023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 11:25:38 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 92B7D1402D8
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2016 11:25:38 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 20 Jan 2016 10:25:37 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F3DA42BB0055
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2016 11:25:34 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0K0PSdM22282438
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2016 11:25:36 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0K0P1iP018172
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2016 11:25:02 +1100
Subject: Re: [PATCH] cxl: Add cxl_read_adapter_vpd() to the kernel API
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, linuxppc-dev@ozlabs.org
References: <1453223694-5190-1-git-send-email-fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <569ED3C4.7090505@au1.ibm.com>
Date: Wed, 20 Jan 2016 11:24:36 +1100
MIME-Version: 1.0
In-Reply-To: <1453223694-5190-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/01/16 04:14, Frederic Barrat wrote:
> Introduce a new API to read the VPD of the adapter. In bare-metal, a
> kernel driver can find out the adapter pci_dev behind the AFU device
> and call pci_read_vpd() directly, but it won't work in a (powerVM)
> guest.
> Current implementation is a stub to allow existing drivers (cxlflash)
> to start using it.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Looks fine to me.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
