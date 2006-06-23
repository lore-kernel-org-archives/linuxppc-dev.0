Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D720467A3E
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 04:12:34 +1000 (EST)
In-Reply-To: <E1Ftncn-0008Kb-PT@jdl.com>
References: <E1Frjet-0004PA-J1@jdl.com>
	<D9D3C577-D46A-47BA-A1E0-844B95061F57@kernel.crashing.org>
	<6C66805F-22DD-4EC2-B852-101BF1E84612@kernel.crashing.org>
	<E1Ftncn-0008Kb-PT@jdl.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2983F459-A1C2-4D45-BC61-2B3C94E9B414@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 8641 open nits 
Date: Fri, 23 Jun 2006 13:12:30 -0500
To: Jon Loeliger <jdl@jdl.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 23, 2006, at 10:31 AM, Jon Loeliger wrote:

> So, like, the other day Kumar Gala mumbled:
>> Jon,
>>
>> Any update on the following nits:
>> * duplication of entry in cputable
>
> Earlier, we discussed it internally, and there are a few
> issues differentiating the cores, so the sentiment was to
> leave it as is for now.

Can this be explained, I dont like the idea of having an entry to  
matches on specific version and does have any differences with the  
generic match.  Why not remove it now and when you have something  
that is special for 864x that we add it then.

>> * include of <platforms/86xx/mpc8641_hpcn.h> in asm-powerpc/mpc86xx.h
>
> That has to stay unless the IRQ patch is applied first.
> Ben said "No" to that one so far.  The include stays for now.

I dont follow, what IRQ information is in mpc8641_hpcn.h that is  
needed by mpc86xx.h?

>> * mpc86xx_exclude_device cleanup and movement to pci.c
>> * fixing up mpc86xx_hpcn_probe()
>
> Those are all going to be cleaned up pending Ben's IRQ rewrite.

What does probe have to do with Ben's IRQ rewrite?

- kumar
