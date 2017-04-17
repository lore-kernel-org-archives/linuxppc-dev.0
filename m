Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w5vHD3v6QzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 13:43:03 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3H3cXvE062499
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Apr 2017 23:43:00 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29ufnk1v90-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Apr 2017 23:43:00 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 13:42:57 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3H3glKx59310222
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 13:42:55 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3H3gNsv027167
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 13:42:23 +1000
Subject: Re: [PATCH] selftests/powerpc/mm: Add a test for virtual address
 mapping
To: Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
References: <20170412094112.13181-1-khandual@linux.vnet.ibm.com>
 <20170414221857.58171fce@neko>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: "'Kirill A. Shutemov'" <kirill.shutemov@linux.intel.com>
Date: Mon, 17 Apr 2017 09:11:57 +0530
MIME-Version: 1.0
In-Reply-To: <20170414221857.58171fce@neko>
Content-Type: text/plain; charset=windows-1252
Message-Id: <adcab8f9-8c11-0678-a87f-8adb80d58a67@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/15/2017 01:48 AM, Michal Suchanek wrote:
> Hello,
> 
> On Wed, 12 Apr 2017 15:11:12 +0530
> Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
> 
>> This verifies virtual address mapping below and above the
>> 128TB range and makes sure that address returned are within
>> the expected range depending upon the hint passed from the
>> user space.
> 
> This description does not mention anything PPC specific. Can this be
> generalized to work with Intel L5 enabled kernel as well?

Hmm, I am not completely aware about the proposed mmap interface
for 128TB and beyond till 512TB by Kirill on x86. If both powerpc
and x86 will have the same semantics, then this test is generic
enough to cover both the architectures and will move it into
selftests/vm/ instead of current selftests/powerpc/mm.
