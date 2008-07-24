Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 49F26DDF2A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 18:17:37 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id m6O8HWxa099308
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 08:17:32 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m6O8HWFw196856
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 10:17:32 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m6O8HWmm003587
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 10:17:32 +0200
Message-ID: <48883A9B.3050608@linux.vnet.ibm.com>
Date: Thu, 24 Jul 2008 10:17:31 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH 0/6][RFC] kvmppc: paravirtualization interface
References: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<20080724020112.GM20457@bakeyournoodle.com>
In-Reply-To: <20080724020112.GM20457@bakeyournoodle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, embedded-hypervisor@power.org, hollisb@us.ibm.com,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tony Breeds wrote:
> On Wed, Jul 23, 2008 at 10:36:41AM +0200, ehrhardt@linux.vnet.ibm.com wrote:
>   
>> From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
>>
>> This patch series implements a paravirtualization interface using:
>> - the device tree mechanism to pass hypervisor informations to the guest
>> - hypercalls for guest->host calls
>> - an example exploiter of that interface (magic page)
>> This is work in progress, but working so far. I just start to really exploit
>> the fuctionality behind the magic page mechanism therefor I can't provide any
>> performance improvements so far, but it is evolved enough for RFC and to start
>> the standardization discussion.
>>     
>
> Are you aiming this for the current merge window, ie for 2.6.27?
>   
The aim is not really fixed. It would be nice to get into 2.6.27, but 
since I can't yet expect how long it takes ...

Actually the guest patches would already go through reviews and 
upstream, due to the fact that the guest code changes are not that (the 
major part of the implementation will go over kvmppc -> kvm upstream).
But since I want to discuss about the standardization on the embedded 
hypervisor list first, the naming of the device tree entries are not 
fixed yet.
Therefor I can't yet define which kernel version merge window I'll 
target/reach.

btw - embedded hypervisor - I got advised that this is a closed list 
which I forgot.
Sorry for all who got bounces on a replay-all action. The next version 
of the patch series will go to the involved open source lists only and a 
separate more standardization than patch style mail series to embedded 
hypervisor.

> Yours Tony
>
>   linux.conf.au    http://www.marchsouth.org/
>   Jan 19 - 24 2009 The Australian Linux Technical Conference!
>   
-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization
