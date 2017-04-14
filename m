Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w4Jd65R8XzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 23:38:02 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3EDXT2Y133827
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 09:37:55 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29tsptc670-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 09:37:54 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 14 Apr 2017 19:07:51 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3EDbgwS18546692
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 19:07:42 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3EDblRw022234
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 19:07:48 +0530
Subject: Re: [PATCH 1/3] powerpc/mm: Rename variable to reflect start address
 of a section
To: linuxppc-dev@lists.ozlabs.org
References: <20170406141450.16060-1-khandual@linux.vnet.ibm.com>
Cc: aneesh.kumar@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 14 Apr 2017 19:07:41 +0530
MIME-Version: 1.0
In-Reply-To: <20170406141450.16060-1-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <15325398-8566-5c1a-4252-e55213f1c195@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/06/2017 07:44 PM, Anshuman Khandual wrote:
> The commit (16a05bff1: powerpc: start loop at section start of
> start in vmemmap_populated()) reused 'start' variable to compute
> the starting address of the memory section where the given address
> belongs. Then the same variable is used for iterating over starting
> address of all memory sections before reaching the 'end' address.
> Renaming it as 'section_start' makes the logic more clear.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> Previous discussions on this http://patchwork.ozlabs.org/patch/584103/

Hello Michael,

Are you okay with this cleanup, we had discussed about this before which
can be pulled up from the link above. The other two patches are just
in-code documentation addition to relevant files.

Regards
Anshuman
