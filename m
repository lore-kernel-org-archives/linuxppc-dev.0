Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP5Q866nnzDqpf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 17:11:28 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1G68nUx008161
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 01:11:26 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28mstgw9pk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 01:11:26 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 16:11:23 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 349CC2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 17:11:20 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1G6BC8624510712
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 17:11:20 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1G6Allq020677
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 17:10:47 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 "# v4 . 8+" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] pci/hotplug/pnv-php: Remove WARN_ON() in
 pnv_php_put_slot()
In-Reply-To: <6c4942ee-7704-5686-8bf3-3cff775eff89@au1.ibm.com>
References: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1487200954-14681-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <6c4942ee-7704-5686-8bf3-3cff775eff89@au1.ibm.com>
Date: Thu, 16 Feb 2017 11:40:15 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a89mbr94.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
>> Cc: <stable@vger.kernel.org> # v4.8+
>> Fixes: 66725152fb9f ("PCI/hotplug: PowerPC PowerNV PCI hotplug driver")
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Tested-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
