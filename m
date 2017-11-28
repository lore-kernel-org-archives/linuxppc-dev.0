Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymfGb1MsVzDrJJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 09:58:30 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vASMrbs1073085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 17:58:27 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ehgavht0q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 17:58:27 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 28 Nov 2017 17:58:26 -0500
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V8 0/3] powerpc/nodes: Fix issues with memoryless nodes
Date: Tue, 28 Nov 2017 16:58:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <79bd4c96-2381-c9b1-8222-b350e069655b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/nodes: Ensure enough nodes avail for operations

powerpc/initnodes: Ensure nodes initialized for hotplug

hotplug/cpu: Fix crash with memoryless nodes

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (3):
  powerpc/nodes: Ensure enough nodes avail for operations
  powerpc/initnodes: Ensure nodes initialized for hotplug
  hotplug/cpu: Fix crash with memoryless nodes
---
Changes in V8:
  -- Remove unneeded pr_info() statement
  -- Clarify 'resources' as 'CPUs' in patch description regarding
     VPHN call.  Add another clause to statement mentioning that
     shared CPUs start in node 0, and are finally assigned per
     VPHN information.
  -- Change a 'printk(KERN_INFO ...)' statement to be a pr_debug()
     statement.
  -- Rename 'find_cpu_nid' to 'find_and_online_cpu_nid' for better
     clarity of its function.
  -- Restore '__init' tag to definition of 'setup_node_data'
