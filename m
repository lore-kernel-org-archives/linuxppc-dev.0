Return-Path: <bharata@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTHDt6N0yzDqgc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 14:47:10 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5E4jLL9116371
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 00:47:08 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23get0r8x0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 00:47:08 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 14:47:03 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5468F2BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 14:47:00 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5E4l03j11862272
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 14:47:00 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5E4kxw2018237
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 14:46:59 +1000
Date: Tue, 14 Jun 2016 10:16:51 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: david@gibson.dropbear.id.au, nfont@linux.vnet.ibm.com, aik@au1.ibm.com,
 mpe@ellerman.id.au
Subject: Re: [FIX PATCH v2 0/2] Fix powerpc,numa: Fix memory_hotplug_max()
Reply-To: bharata@linux.vnet.ibm.com
References: <1463060055-24158-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463060055-24158-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <20160614044651.GB5916@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 12, 2016 at 07:04:13PM +0530, Bharata B Rao wrote:
> This patchset fixes memory_hotplug_max() routine to return correct
> value of maximum hotpluggable address.
> 
> In this version, whitespace fixes are separated into a different patch.
> 
> v2: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg103342.html
> 
> Bharata B Rao (2):
>   powerpc,numa: Fix whitespace in hot_add_drconf_memory_max()
>   powerpc,numa: Fix memory_hotplug_max()
> 
>  arch/powerpc/mm/numa.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)

Can this fix be considered for inclusion ? Should I be posting this against
latest git now ?

Regards,
Bharata.
