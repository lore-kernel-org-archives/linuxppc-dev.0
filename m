Return-Path: <bergner@vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS8dV396tzDvk0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 01:46:37 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uASEin7a037184
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 09:46:34 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 270nw73j9e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 09:46:34 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bergner@vnet.ibm.com>;
 Mon, 28 Nov 2016 09:46:33 -0500
Subject: Re: [RFC][PATCH] Update ppc disassembly in xmon
To: Balbir Singh <bsingharora@gmail.com>
References: <6229e33e-2d6e-25d8-4206-2b62f3a11500@gmail.com>
 <9f8b3a9a-3744-6452-5c33-bcf0cdbdaa21@au1.ibm.com>
 <75641461-a8c1-075f-c7f6-0cee6f29f379@gmail.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Peter Bergner <bergner@vnet.ibm.com>
Date: Mon, 28 Nov 2016 08:46:29 -0600
MIME-Version: 1.0
In-Reply-To: <75641461-a8c1-075f-c7f6-0cee6f29f379@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d8c4ff58-8d48-cdc8-5c86-3dc420c835c1@vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/23/16 11:52 PM, Balbir Singh wrote:
>
>
> On 24/11/16 16:14, Andrew Donnellan wrote:
>> On 24/11/16 13:05, Balbir Singh wrote:
>>> 9. The license for these files is now GPL v3 or later
>>
>> As much as I love the GPLv3, isn't this an instant NAK?
>>
>
> Thats why I called it out, my bad though I should have done
> a stronger check than just "git grep "version 3"" which matched
> scripts/kconfig/zconf.tab.c_shipped -- derived from bison, which
> can itself be licensed differently
>
> Michael, please hold these patches and don't merge them yet.

You should double check, but if all of the changes are from IBM
(ie, Alan and I), then as the authors of the changes, we have the
right to relicense the changes, so we could backport them as GPLv2.

Peter
