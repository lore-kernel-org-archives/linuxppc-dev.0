Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11F6D1A0B82
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:20:49 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 4 Mar 2016 09:20:49 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E8ED22CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:20:45 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u23NKbSZ5505342
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:20:45 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u23NKDTW031534
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:20:13 +1100
Subject: Re: [PATCH] cxl: Ignore probes for virtual afu pci devices
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1456724453-10152-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Cc: mikey@neuling.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56D8C676.8010302@au1.ibm.com>
Date: Fri, 4 Mar 2016 10:19:18 +1100
MIME-Version: 1.0
In-Reply-To: <1456724453-10152-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29/02/16 16:40, Vaibhav Jain wrote:
> Add a check at the beginning of cxl_probe function to ignore virtual pci
> devices created for each afu registered. This fixes the the errors
> messages logged about missing CXL vsec, when cxl probe is unable to
> find necessary vsec entries in device pci config space. The error
> message logged are of the form :
>
> cxl-pci 0004:00:00.0: ABORTING: CXL VSEC not found!
> cxl-pci 0004:00:00.0: cxl_init_adapter failed: -19
>
> Cc: Ian Munsie <imunsie@au1.ibm.com>
> Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Looks good to me.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
