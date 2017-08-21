Return-Path: <martin.petersen@oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xblVm2qxpzDqfg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 06:22:56 +1000 (AEST)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v7LKMr9X028334
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 20:22:54 GMT
To: Brian King <brking@linux.vnet.ibm.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "abdhalee\@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>,
 "sachinp\@linux.vnet.ibm.com" <sachinp@linux.vnet.ibm.com>,
 "sfr\@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "hare\@suse.com" <hare@suse.com>,
 "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-next\@vger.kernel.org" <linux-next@vger.kernel.org>,
 "hch\@lst.de" <hch@lst.de>
Subject: Re: [PATCH] ipr: Set no_report_opcodes for RAID arrays
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1502902815.3305.22.camel@abdul.in.ibm.com>
 <1502904072.2421.3.camel@wdc.com>
 <2f686064-3e32-df8d-134f-962b5181da9d@linux.vnet.ibm.com>
 <1502985161.2615.8.camel@wdc.com>
 <71fb9c1b-9f3f-acdc-8bb5-aa1240aea763@linux.vnet.ibm.com>
 <c2272791-2010-600b-3982-835b8eb1a523@linux.vnet.ibm.com>
Date: Mon, 21 Aug 2017 16:22:41 -0400
In-Reply-To: <c2272791-2010-600b-3982-835b8eb1a523@linux.vnet.ibm.com> (Brian
 King's message of "Fri, 18 Aug 2017 16:17:32 -0500")
Message-ID: <yq1lgmcekmm.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Brian,

> Since ipr RAID arrays do not support the MAINTENANCE_IN /
> MI_REPORT_SUPPORTED_OPERATION_CODES, set no_report_opcodes to prevent
> it from being sent.

Applied to 4.13/scsi-fixes. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
