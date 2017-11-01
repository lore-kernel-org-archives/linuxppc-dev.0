Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRyCc3hsTzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 05:58:04 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA1Iusj2046266
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Nov 2017 14:58:01 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dyg4un0h1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 14:58:01 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 1 Nov 2017 14:58:00 -0400
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, John Allen
 <jallen@linux.vnet.ibm.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH V6 0/2] pseries/nodes: Fix issues with memoryless nodes
Date: Wed, 1 Nov 2017 13:57:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <b7c79722-f4fb-05f5-74b9-98030fa31f38@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pseries/nodes: Ensure enough nodes avail for operations

pseries/initnodes: Ensure nodes initialized for hotplug

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (2):
  pseries/nodes: Ensure enough nodes avail for operations
  pseries/initnodes: Ensure nodes initialized for hotplug
---
Changes in V6:
  -- Remove some node initialization/allocation from boot setup
  -- Add some needed node initialization to runtime code that maps
     CPUs based on VPHN associativity
  -- Add error checks and alternate recovery for compile flag
     CONFIG_MEMORY_HOTPLUG
  -- Add alternate node selection recovery for !CONFIG_MEMORY_HOTPLUG
