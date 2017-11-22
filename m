Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhYvr41WBzDqqV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 18:28:07 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAM7O7Wv079621
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 02:28:05 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ed4jhgjbt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 02:28:04 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 22 Nov 2017 07:28:03 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
Subject: Re: [PATCH] cxl: Check if vphb exists before iterating over AFU
 devices
In-Reply-To: <8c71f549-7000-857b-8b98-6e01976f153c@au1.ibm.com>
References: <20171122054615.18092-1-vaibhav@linux.vnet.ibm.com>
 <8c71f549-7000-857b-8b98-6e01976f153c@au1.ibm.com>
Date: Wed, 22 Nov 2017 12:57:58 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878teykc1t.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
> Looks to me like we might need the same fix in 
> cxl_vphb_error_detected()? It's called twice in 
> cxl_pci_error_detected(), and in only one of those cases is it 
> surrounded by an afu->phb NULL check.
Thanks for catching this. Will send a v2 with update.


-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
