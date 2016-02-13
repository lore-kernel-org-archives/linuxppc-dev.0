Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C776D1A0013
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 16:15:13 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 13 Feb 2016 00:15:11 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 160E7C90042
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 00:15:07 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1D5F9O215270002
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 05:15:09 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1D5Bkfa013827
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 00:11:46 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 00/29] Book3s abstraction in preparation for new MMU
 model
In-Reply-To: <20160212041457.GE13831@oak.ozlabs.ibm.com>
References: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160212041457.GE13831@oak.ozlabs.ibm.com>
Date: Sat, 13 Feb 2016 10:45:04 +0530
Message-ID: <87wpq9qjhj.fsf@linux.vnet.ibm.com>
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

Paul Mackerras <paulus@ozlabs.org> writes:

> On Mon, Feb 08, 2016 at 02:50:12PM +0530, Aneesh Kumar K.V wrote:
>> Hello,
>> 
>> This is a large series, mostly consisting of code movement. No new features
>> are done in this series. The changes are done to accomodate the upcoming new memory
>> model in future powerpc chips. The details of the new MMU model can be found at
>> 
>>  http://ibm.biz/power-isa3 (Needs registration). I am including a summary of the changes below.
>
> This series doesn't seem to apply against either v4.4 or Linus'
> current master.  What is this patch against?
>

The patchset have dependencies against other patcheset posted to the
list. The best option is to pull the branch mentioned instead of trying to
apply them individually.

-aneesh
