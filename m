Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FBKb0BqTzF0wq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 13:26:42 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5Q3JAxZ098526
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 23:26:39 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96rfv9u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 23:26:39 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 26 Jun 2018 04:26:37 +0100
Subject: Re: [PATCH 00/10] cxl: Remove abandonned capi support for the
 Mellanox CX4
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, alastair@au1.ibm.com,
 vaibhav@linux.ibm.com, clombard@linux.ibm.com, felix@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: huyn@mellanox.com
References: <20180625162406.10813-1-fbarrat@linux.ibm.com>
 <21307b77-9c3e-574b-e4af-e61ecc54a803@au1.ibm.com>
Date: Tue, 26 Jun 2018 13:26:32 +1000
MIME-Version: 1.0
In-Reply-To: <21307b77-9c3e-574b-e4af-e61ecc54a803@au1.ibm.com>
Message-Id: <549de3ef-e340-c648-ce47-547664ced862@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26/06/18 12:31, Andrew Donnellan wrote:
> 9 of these commits are missing Signed-off-bys.
> 
> git revert -s is a thing :)

After mentally preparing myself for the flashbacks from when we had to 
implement some of these hacks in the first place, I've read through the 
rest of the series and it all looks good!

Consider this entire series, with the signoffs fixed:

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
