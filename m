Return-Path: <mwb@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq7Bw35hqzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 00:47:03 +1000 (AEST)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 19 Apr 2016 08:46:59 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A3345C40014
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 08:35:04 -0600 (MDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3JEkt9T31260758
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 14:46:55 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3JEebj8009623
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 10:40:37 -0400
Subject: Re: [RFC] powerpc/devtree: Parse new DRC mem/cpu/dev device, tree
 elements
To: linuxppc-dev@lists.ozlabs.org, stewart@linux.vnet.ibm.com
References: <mailman.1273.1458018931.5573.linuxppc-dev@lists.ozlabs.org>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Message-ID: <571644DE.4030408@linux.vnet.ibm.com>
Date: Tue, 19 Apr 2016 09:46:54 -0500
MIME-Version: 1.0
In-Reply-To: <mailman.1273.1458018931.5573.linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/15/2016 12:15 AM, linuxppc-dev-request@lists.ozlabs.org wrote:


> Documentation/devicetree/bindings ? or link to PAPR where it's specified?
>
> -- 
> Stewart Smith
< OPAL Architect, IBM.

Here's the link to the Notes PAPR database's issue: notes://D01DBR12/86256680004635D2/565907e362ce41e28625636a000fba97/b2fa2e426b3222fd85257e810050443c

In case you don't have access to the database, here are the document headings attached to the issue:

10/21/15 : Updated Section:  C.6.6.2 ibm,dynamic-reconfiguration-memory to remove lmb-size from ibm,dynamic-memory-v2; corrected typo in C.6.6.2.
(See attached file: C PAPR Binding.doc)


10/21/15 : changed ibm,drc-index to drc-index in Section 7.3.28 and R1-7.3.28-14; added ibm,drc-info in the root and vdevice nodes in the Partition Migration/Hibernation section of Table 129.
(See attached file: Chapter 7 .doc)


10/21/15 : Updated reference " ... the drc-xxx or ibm,drc-info property ..." in Section 13.5.3.2. Added  "See 13.5.2.8 for additional information." to the first paragraph of sections 13.5.2.2, 13.5.2.4, 13.5.2.5, 13.5.2.6 : In the first paragraph of each section, add
(See attached file: Chapter 13.doc)

(See attached file: Chapter 17 and 18.doc)

(See attached file: Chapter 5 .doc)

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
