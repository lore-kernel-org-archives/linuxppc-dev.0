Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhTjY4dsMzDqZ6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 23:18:41 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7TDFCDO098043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 09:18:40 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cn4211cdf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 09:18:39 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Tue, 29 Aug 2017 07:18:39 -0600
Subject: Re: [PATCH] powerpc/kernel: Change retrieval of pci_dn
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: martin.petersen@oracle.com, linuxppc-dev@lists.ozlabs.org,
 "Bryant G. Ly" <bgly@us.ibm.com>
References: <1503936303-18274-1-git-send-email-bryantly@linux.vnet.ibm.com>
 <87tw0q289e.fsf@concordia.ellerman.id.au>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 08:18:34 -0500
MIME-Version: 1.0
In-Reply-To: <87tw0q289e.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <560467db-963b-46f1-bb7b-63892fb5496d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 8/29/17 1:33 AM, Michael Ellerman wrote:

> "Bryant G. Ly" <bryantly@linux.vnet.ibm.com> writes:
>
>> For a PCI device it's pci_dn can be retrieved from
>> pdev->dev.archdata.firmware_data, PCI_DN(devnode), or parent's list.
>> Thus, we should just use the generic function pci_get_pdn_by_devfn
>> to get the pci_dn.
>>
>> Signed-off-by: Bryant G. Ly <bgly@us.ibm.com>
> Minor issue, it's preferable if the email in your Signed-off-by matches
> the email you send patches from.
>
> cheers
>
Hi Michael,

Thanks for the review. I apologize for the email's not matching, I switch between the two frequently
throughout the day for internal gerrit commits and Linux patches. I have addressed all your comments
in the new patch that I had just put up. Also, I have tested it with mellanox cx4 cards on P8 systems.

I'd also like to let you know that I am working on patches to enable SRIOV on power and would like
your feedback on design, which I will send in a private email.

-Bryant
