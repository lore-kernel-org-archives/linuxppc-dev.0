Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id B1096DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 00:59:05 +1100 (EST)
Date: Mon, 30 Mar 2009 17:59:03 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Build error
Message-ID: <20090330135903.GA11614@oksana.dev.rtsoft.ru>
References: <1238383506.17330.0.camel@pasglop>
	<7E26E694-85F8-445F-9113-88DCD61BC32C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <7E26E694-85F8-445F-9113-88DCD61BC32C@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 30, 2009 at 08:51:38AM -0500, Kumar Gala wrote:
>
> On Mar 29, 2009, at 10:25 PM, Benjamin Herrenschmidt wrote:
>
>> My next branch (after merging from you):
>>
>> ERROR: "fsl_pq_mdio_bus_name" [drivers/net/gianfar_driver.ko]  
>> undefined!
>>
>> I'll ask Linus to pull anyway though.
>>
>> Cheers,
>> Ben.
>
> I believe this is fixed in net-next (and possible linus has already  
> pulled that in.)

FWIW, I can't reproduce the issue neither in benh/powerpc.git `next'
branch nor in `merge' branch...

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
