Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9Z8J6qnGzDr1r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 16:04:00 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7C5wsG8073025
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 02:03:58 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24s2v7jr6f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 02:03:58 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 12 Aug 2016 16:03:56 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E3B803578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 16:03:53 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7C63r5923265424
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 16:03:53 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7C63rXe008756
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 16:03:53 +1000
Subject: Re: [PATCH v4] powerpc/pseries: use pci_host_bridge.release_fn() to
 kfree(phb)
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
References: <1470947140-16366-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20160812055448.GA4393@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 12 Aug 2016 16:03:52 +1000
MIME-Version: 1.0
In-Reply-To: <20160812055448.GA4393@gwshan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <fd9c2b76-cb67-750d-db62-fd820c9a028f@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/08/16 15:54, Gavin Shan wrote:
> It might be nicer for users to implement their own pcibios_free_controller_deferred(),
> meaning pSeries needs its own implementation for now. The reason is more user (pSeries)
> specific objects can be released together with the PHB. However, I'm still fine without
> the comment to be covered.

That's probably not a bad idea, though from a cxl perspective I'm fine 
with using the current version.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
