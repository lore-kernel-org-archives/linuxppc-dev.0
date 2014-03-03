Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4FF412C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2014 06:15:30 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 4 Mar 2014 05:15:28 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9121B2CE803F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2014 06:15:24 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s23JFALo5702032
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Mar 2014 06:15:10 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s23JFNak011699
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Mar 2014 06:15:23 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Mel Gorman <mgorman@suse.de>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: Panic on ppc64 with numa_balancing and !sparsemem_vmemmap
In-Reply-To: <20140303172649.GU6732@suse.de>
References: <20140219180200.GA29257@linux.vnet.ibm.com>
 <20140303172649.GU6732@suse.de>
Date: Tue, 04 Mar 2014 00:45:19 +0530
Message-ID: <874n3fxfeg.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: riel@redhat.com, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mel Gorman <mgorman@suse.de> writes:

> On Wed, Feb 19, 2014 at 11:32:00PM +0530, Srikar Dronamraju wrote:
>> 
>> On a powerpc machine with CONFIG_NUMA_BALANCING=y and CONFIG_SPARSEMEM_VMEMMAP
>> not enabled,  kernel panics.
>> 
>
> This?

This one fixed that crash on ppc64

http://mid.gmane.org/1393578122-6500-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com

-aneesh
