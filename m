Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rk5P068nJzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 11:08:35 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u65151H2130363
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 21:08:33 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23x77xfu94-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jul 2016 21:08:32 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 5 Jul 2016 11:08:29 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6BF5B3578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 11:08:28 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6518SAj11534834
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 11:08:28 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6518RHf003886
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 11:08:28 +1000
Subject: Re: [PATCH 12/14] PCI/hotplug: pnv_php: export symbols and move
 struct types needed by cxl
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-13-git-send-email-imunsie@au.ibm.com>
 <20160705000347.GA6557@gwshan>
Cc: Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Huy Nguyen <huyn@mellanox.com>, linuxppc-dev@lists.ozlabs.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 5 Jul 2016 11:08:25 +1000
MIME-Version: 1.0
In-Reply-To: <20160705000347.GA6557@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <df5d692d-64b1-d6a2-07bc-26774cbd8a1b@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/16 10:03, Gavin Shan wrote:
> Andrew/Ian, it seems HOTPLUG_PCI_POWERNV_BASE isn't defined and we needn't it.

Argh, thanks for picking that up! I removed that option and all its 
occurrences in the code based on your earlier private feedback but 
forgot to drop this.

Will fix in V2.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
