Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdVG02FPCzF0bR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 09:33:27 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w19MSn7m050356
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Feb 2018 17:33:25 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g1hbjxvv3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Feb 2018 17:33:24 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 9 Feb 2018 17:33:24 -0500
Subject: Re: [PATCH] pseries: Fix build break for SPLPAR=n and CPU hotplug
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mwb@linux.vnet.ibm.com
References: <151820002192.57762.14326361815004034389.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Fri, 9 Feb 2018 14:33:04 -0800
MIME-Version: 1.0
In-Reply-To: <151820002192.57762.14326361815004034389.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <88d0b9a1-d995-21cb-e801-553ad64fac93@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/09/2018 10:13 AM, Nathan Fontenot wrote:
> Build break fix for SPLPAR=n builds and CPU hotplug.
> 
> arch/powerpc/platforms/pseries/hotplug-cpu.o: In function `.dlpar_online_cpu':
> hotplug-cpu.c:(.text+0xc40): undefined reference to `.find_and_online_cpu_nid'
> 
> Move the declaration of find_and_online_cpu_nid() to topology.h where
> we can define it as a no-op for SPLAPR=n builds.
> 
> Fixes: e67e02a ("powerpc/pseries: Fix cpu hotplug crash with memoryless nodes")
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> ---

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
