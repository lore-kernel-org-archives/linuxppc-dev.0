Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJzTw0BMkzDvnh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 09:30:10 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAGMSVTb082792
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 17:30:08 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26rx2d5gm5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 17:30:07 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 17 Nov 2016 08:30:05 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 47EC83578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 09:30:03 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAGMU35324117384
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 09:30:03 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAGMU2fi002178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 09:30:03 +1100
Subject: Re: [PATCH] cxl: Fix potential build failure - select ANON_INODES
To: Ben Hutchings <ben@decadent.org.uk>, linuxppc-dev@lists.ozlabs.org
References: <20161116182916.GF2697@decadent.org.uk>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 17 Nov 2016 09:30:00 +1100
MIME-Version: 1.0
In-Reply-To: <20161116182916.GF2697@decadent.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f19ce00a-68e3-1f86-94ce-2d5126ec4843@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17/11/16 05:29, Ben Hutchings wrote:
> cxl calls anon_inode_get() so must select ANON_INODES.
>
> Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Thanks for catching this.

Is this patch still necessary once 
http://patchwork.ozlabs.org/patch/694415/ is applied though?

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
