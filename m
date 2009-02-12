Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 965BEDDDB4
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 08:03:41 +1100 (EST)
Message-ID: <49948EA7.2080301@emcraft.com>
Date: Fri, 13 Feb 2009 00:03:35 +0300
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: rework dma-noncoherent to use generic vmap/vunmap
	functions
References: <1231505915-16082-1-git-send-email-yanok@emcraft.com>	
	<1233722625.16867.249.camel@pasglop> <49945EFE.8000401@emcraft.com>
	<1234471294.29851.59.camel@pasglop>
In-Reply-To: <1234471294.29851.59.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

Benjamin Herrenschmidt wrote:
>> btw, ioremap doesn't provide useful 'caller').
>>     
>
> I fixed that :-) (see patches I posted to the list, though that's
> waiting for a patch to go upstream first that adds a
> __get_vm_area_caller() that I need for ppc64).
>   

Yep, I saw them. Btw, I've posted update consistent memory patch in a
new thread please take a look.

Regards, Ilya.
