Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5D9262C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 14:43:55 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 12 Feb 2014 09:13:52 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7C8BF394005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 09:13:50 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1C3hjES40697888
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 09:13:45 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1C3hn6t020050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 09:13:50 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, riel@redhat.com,
 mgorman@suse.de, mpe@ellerman.id.au
Subject: [PATCH V2 0/3] powerpc: Fix random application crashes with
 NUMA_BALANCING enabled
Date: Wed, 12 Feb 2014 09:13:35 +0530
Message-Id: <1392176618-23667-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

This patch series fix random application crashes observed on ppc64 with numa
balancing enabled. Without the patch we see crashes like

anacron[14551]: unhandled signal 11 at 0000000000000041 nip 000000003cfd54b4 lr 000000003cfd5464 code 30001
anacron[14599]: unhandled signal 11 at 0000000000000041 nip 000000003efc54b4 lr 000000003efc5464 code 30001

Changes from V1:
* Build fix for CONFIG_NUMA_BALANCING disabled

-aneesh
