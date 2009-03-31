Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 105B3DDE17
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 10:51:43 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e39.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n2VNmdpJ020350
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 17:48:39 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2VNpehT219936
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 17:51:40 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2VNpeU1008736
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 17:51:40 -0600
Date: Tue, 31 Mar 2009 19:50:57 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Add hvc_console to MAINTAINERS
Message-ID: <20090331235057.GB563@zod.rchland.ibm.com>
References: <49BF956B.9030109@gmail.com>
	<20090330133531.f5d99c09.akpm@linux-foundation.org>
	<20090330205553.GA19278@yoda.jdub.homelinux.org>
	<20090330141852.59baaeda.akpm@linux-foundation.org>
	<20090331132944.GB2332@yoda.jdub.homelinux.org>
	<1238543040.6522.10.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1238543040.6522.10.camel@localhost>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	roel.kluin@gmail.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 01, 2009 at 10:44:00AM +1100, Michael Ellerman wrote:
>On Tue, 2009-03-31 at 09:29 -0400, Josh Boyer wrote:
>> Add a MAINTAINERS entry for the hypervisor virtual console support
>> used on IBM POWER servers.
>> 
>> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>> ---
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c5f4e9d..387ad45 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2176,6 +2176,11 @@ W:       http://www.ia64-linux.org/
>>  T:     git kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6.git
>>  S:     Maintained
>>  
>> +IBM HYPERVISOR VIRTUAL CONSOLE
>> +P:     Several
>> +L:     linuxppc-dev@ozlabs.org
>> +S:     Maintained
>
>I don't think it's the "IBM" Hypervisor virtual console driver anymore.
>There are backends for Xen, Beat (Toshiba) and virtio. 

Was just going by the copyright in the files, and Documentation/powerpc/hvc*

Also, if there are other backends, then is the list specified really
correct?  Perhaps it should just be linux-kernel.

Guess that's the problem with trying to add a maintainers entry for something
that doesn't really have a specific maintainer.

josh
