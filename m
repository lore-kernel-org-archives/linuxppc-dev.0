Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnSgH3YbqzDq95
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 20:48:27 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2L9csRR106882
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 05:48:16 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ajjrre72-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 05:48:16 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 09:48:11 -0000
Subject: Re: [PATCH V2 0/6] cxl: Add support for Coherent Accelerator
 Interface Architecture 2.0
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1489489722-935-1-git-send-email-clombard@linux.vnet.ibm.com>
 <34d30acd-5352-0ef5-1282-b58057a36d62@au1.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Tue, 21 Mar 2017 10:47:41 +0100
MIME-Version: 1.0
In-Reply-To: <34d30acd-5352-0ef5-1282-b58057a36d62@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a6c71458-07fd-e7b8-8781-98c83fbb111f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 21/03/2017 à 03:47, Andrew Donnellan a écrit :
> On 14/03/17 22:08, Christophe Lombard wrote:
>> The first 3 patches are mostly cleanup and fixes, separating the
>> psl8-specific code from the code which will also be used for psl9.
>> Patches 4 restructure existing code, to easily add the psl
>> implementation.
>> Patch 5 and 6 rename and isolate implementation-specific code.
>> Patch 7 introduces the core of the PSL9-specific code.
>
> Is patch 1 (cxl: Read vsec perst load image) from the last version of 
> the series missing in this one?
>
>
Hum. Good point !. It will be present again in V3.
sorry about that.
