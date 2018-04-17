Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QD2g3XpJzDqRk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 15:14:51 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3H5EbSG054526
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 01:14:48 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hd6g08w5k-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 01:14:48 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 17 Apr 2018 06:14:45 +0100
Subject: Re: [PATCH] cxl: Configure PSL to not use APC virtual machines
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>
References: <20180417051102.7577-1-vaibhav@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 17 Apr 2018 15:14:41 +1000
MIME-Version: 1.0
In-Reply-To: <20180417051102.7577-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3f71f55a-3c82-cf7e-1ceb-0f327411d862@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17/04/18 15:11, Vaibhav Jain wrote:
> APC virtual machines arent used on POWER-9 chips and are already
> disabled in on-chip CAPP. They also need to be disabled on the PSL via
> 'PSL Data Send Control Register' by setting bit(47). This forces the
> PSL to send commands to CAPP with queue.id == 0.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

LGTM. Does this need to be sent to stable?

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
