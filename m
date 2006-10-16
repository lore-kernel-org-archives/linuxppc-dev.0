Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CEC6C67C6E
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 06:22:28 +1000 (EST)
In-Reply-To: <87slhot3pe.fsf@sleipner.barco.com>
References: <871wp8ukh0.fsf@sleipner.barco.com>
	<1161029148.3172.19.camel@zod.rchland.ibm.com>
	<87slhot3pe.fsf@sleipner.barco.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0371C551-B535-4B95-81F3-8CC95C4FFC82@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] fix ARCH=ppc timer_interrupt after global pt_regs
Date: Mon, 16 Oct 2006 15:22:19 -0500
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 16, 2006, at 3:18 PM, Peter Korsgaard wrote:

>>>>>> "JB" == Josh Boyer <jwboyer@linux.vnet.ibm.com> writes:
>
> Hi,
>
> JB> Kumar Galak already fixed this on Oct 11 in the powerpc git tree.
>
> Ahh, I didn't notice.
>
> JB> Paul, could you send this fix to Linus soon please?
>
> Yes, please - I spend most of the morning tracking this down.

Yeah, akpm picked up the patch for -mm.

- k
