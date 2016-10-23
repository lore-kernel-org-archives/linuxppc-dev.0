Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t1j7V6WvSzDvb2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Oct 2016 12:51:18 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9N1miel104110
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2016 21:51:16 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26810hhu2h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2016 21:51:15 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Sat, 22 Oct 2016 21:51:14 -0400
Date: Sat, 22 Oct 2016 20:51:08 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Alistair Popple <apopple@au1.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tang Chen <tangchen@cn.fujitsu.com>,
 linux-mm@kvack.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 2/5] drivers/of: do not add memory for unavailable nodes
References: <1475778995-1420-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1475778995-1420-3-git-send-email-arbab@linux.vnet.ibm.com>
 <2344394.NlaWgtFOqB@new-mexico>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <2344394.NlaWgtFOqB@new-mexico>
Message-Id: <20161023015107.527l4fvnh2nrup5u@arbab-vm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alistair,

On Fri, Oct 21, 2016 at 05:22:54PM +1100, Alistair Popple wrote:
>From what I can tell it seems that kernels without this patch will try 
>and use this memory even if it is marked in the device-tree as 
>status="disabled" which could lead to problems for older kernels when 
>we start exporting this property from firmware.
>
>Arguably this might not be such a problem in practice as we probably 
>don't have many (if any) existing kernels that will boot on hardware 
>exporting these properties.

Yes, I think you've got it right.

>However given this patch seems fairly independent perhaps it is worth 
>sending as a separate fix if it is not going to make it into this 
>release?

Michael,

If this set as a whole is going to miss the release, would it be helpful 
for me to resend 1/5 and 2/5 as a separate set? They are the minimum 
needed to prevent the possible forward compatibility issue Alistair 
describes.

-- 
Reza Arbab
