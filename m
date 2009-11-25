Return-Path: <nfont@austin.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6E50FB6F15
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 18:07:29 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAP712VH025620
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 00:01:02 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAP77LVR116396
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 00:07:22 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAP794a0027572
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 00:09:05 -0700
Message-ID: <4B0CD7A5.6040203@austin.ibm.com>
Date: Wed, 25 Nov 2009 01:07:17 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/3] Kernel handling of Dynamic Logical Partitioning
References: <4B0C8B45.6080804@austin.ibm.com>
	<19212.41144.253618.357013@cargo.ozlabs.ibm.com>
In-Reply-To: <19212.41144.253618.357013@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, lkml@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Nathan Fontenot writes:
> 
>> The Dynamic Logical Partitioning (DLPAR) capabilities of the powerpc pseries
>> platform allows for the addition and removal of resources (i.e. cpus,
>> memory, pci devices) from a partition. The removal of a resource involves
>> removing the resource's node from the device tree and then returning the
>> resource to firmware via the rtas set-indicator call.  To add a resource, it
>> is first obtained from firmware via the rtas set-indicator call and then a
>> new device tree node is created using the ibm,configure-coinnector rtas call
>> and added to the device tree.
>>
>> The following set of patches implements the needed infrastructure to have the
>> kernel handle the DLPAR addition and removal of cpus (other DLPAR'able items 
>> to follow in future patches).  The framework for this is to create a set of 
>> probe/release sysfs files that will facilitate arch-specific call-outs to 
>> handle addition and removal of cpus to the system.
> 
> Nice explanation, but the 0/3 of the series doesn't go into git.
> Could you rework some/all of this into the commit message for patch
> 1/3 so it gets stored permanently with these patches in git?
> 
> Thanks,
> Paul.

Thanks for all the feedback.

Version two of the patches are on their way based on your comments.

-Nathan Fontenot
