Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsHt36kWJzDqhs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:26:19 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5K6NtbZ079813
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 02:26:17 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b6qen6uyt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 02:26:16 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 16:26:14 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5K6QCD031195216
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:26:12 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5K6Q3YR011886
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:26:03 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC v2 12/12]selftest: Updated protection key selftest
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-13-git-send-email-linuxram@us.ibm.com>
Cc: dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Date: Tue, 20 Jun 2017 11:56:04 +0530
MIME-Version: 1.0
In-Reply-To: <1497671564-20030-13-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <126766e1-070c-7072-1bc8-ebdf6e22db43@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2017 09:22 AM, Ram Pai wrote:
> Added test support for PowerPC implementation off protection keys.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>

First of all, there are a lot of instances where we use *pkru*
named functions on power even the real implementations have
taken care of doing appropriate things. That looks pretty
hacky. We need to change them to generic names first before
adding both x86 and powerpc procedures inside it.
