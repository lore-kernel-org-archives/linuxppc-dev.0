Return-Path: <alastair@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QDPj6jq1zF23r
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 15:31:21 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3H5Twc1060673
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 01:31:19 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hdars06s9-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 01:31:18 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Tue, 17 Apr 2018 06:31:16 +0100
Subject: Re: [PATCH 2/7] powerpc: Use TIDR CPU feature to control TIDR
 allocation
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
 corbet@lwn.net
Date: Tue, 17 Apr 2018 15:31:08 +1000
In-Reply-To: <89476138-a279-761a-21be-4a7cd1d80167@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180417020950.21446-3-alastair@au1.ibm.com>
 <89476138-a279-761a-21be-4a7cd1d80167@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1523943068.3246.3.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-17 at 14:21 +1000, Andrew Donnellan wrote:
> On 17/04/18 12:09, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > Switch the use of TIDR on it's CPU feature, rather than assuming it
> > is available based on architecture.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> 
> There's a use of TIDR in restore_sprs() that's behind the ARCH_300
> flag 
> as well, ideally it should never trigger in the !P9_TIDR case, but
> you 
> might want to update that too for clarity?
> 

Thanks for the review, I'll include your suggestions in the next set.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
