Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHNR90NrczDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 07:08:20 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9IK7LWc082560
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 16:08:18 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpcwd2mgs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 16:08:18 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 18 Oct 2017 16:08:17 -0400
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, John Allen
 <jallen@linux.vnet.ibm.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V2 0/3] pseries/nodes: Fix issues with memoryless nodes
Date: Wed, 18 Oct 2017 15:08:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <cd1c9d3f-c828-2477-ff31-fb6277a8a2aa@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pseries/nodes: Ensure enough nodes avail for operations

pseries/findnodes: Find nodes with memory when booting memoryless nodes

pseries/initnodes: Ensure nodes initialized for hotplug

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (3):
  pseries/nodes: Ensure enough nodes avail for operations
  pseries/findnodes: Find nodes with memory when booting memoryless nodes
  pseries/initnodes: Ensure nodes initialized for hotplug
