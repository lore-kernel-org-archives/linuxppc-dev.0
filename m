Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfZSs2rS2zF0hR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 03:46:32 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1BGiVnK032242
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 11:46:29 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g2k0r0eda-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 11:46:28 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Sun, 11 Feb 2018 16:46:27 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: christophe lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [PATCH 1/3] cxl: Introduce various enums/defines for PSL9 trace
 arrays
In-Reply-To: <ee7a08db-900b-fe9e-7e84-132a871bd38b@linux.vnet.ibm.com>
References: <20180209042535.16845-1-vaibhav@linux.vnet.ibm.com>
 <20180209042535.16845-2-vaibhav@linux.vnet.ibm.com>
 <ee7a08db-900b-fe9e-7e84-132a871bd38b@linux.vnet.ibm.com>
Date: Sun, 11 Feb 2018 22:16:18 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d11b4gpx.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for reviewing the patch Christophe,
christophe lombard <clombard@linux.vnet.ibm.com> writes:

>> +	for (traceid = 0; traceid < CXL_PSL9_TRACEID_MAX; ++traceid) {
>> +		trace_state = CXL_PSL9_TRACE_STATE(trace_cfg, traceid);
>> +		dev_dbg(&dev->dev, "Traceid-%d trace_state=0x%0llX\n",
>>   			traceid, trace_state);
>> 
> any reason to use dev_dbg instead of pr_devel ?
Wanted to distinguish among multiple cxl cards in the system.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
