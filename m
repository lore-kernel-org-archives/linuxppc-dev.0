Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wslVj6QNszDq8c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 10:11:09 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5L08bd6130784
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 20:11:07 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7amvq6wv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 20:11:07 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 20 Jun 2017 20:11:06 -0400
Date: Tue, 20 Jun 2017 17:10:55 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [RFC v2 12/12]selftest: Updated protection key selftest
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-13-git-send-email-linuxram@us.ibm.com>
 <126766e1-070c-7072-1bc8-ebdf6e22db43@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <126766e1-070c-7072-1bc8-ebdf6e22db43@linux.vnet.ibm.com>
Message-Id: <20170621001055.GE5845@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 20, 2017 at 11:56:04AM +0530, Anshuman Khandual wrote:
> On 06/17/2017 09:22 AM, Ram Pai wrote:
> > Added test support for PowerPC implementation off protection keys.
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> 
> First of all, there are a lot of instances where we use *pkru*
> named functions on power even the real implementations have
> taken care of doing appropriate things. That looks pretty
> hacky. We need to change them to generic names first before
> adding both x86 and powerpc procedures inside it.

I have abstracted out the arch-specific code. References to
pkru should now be constricted to x86 code only. 

The patch, i acknowledge, is not easily reviewable.
As Michael Ellermen mentioned I will  break them into two patches.
One moves the file and the second does the code changes. That way
it will be easy to review.

RP
