Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DA24DDF15
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 05:51:40 +1100 (EST)
Message-Id: <A53D4E40-E15F-433B-A9DE-9359533C17F8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081218160256.GA14419@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Long boot delay on 460EX with 2.6.28-rc8
Date: Thu, 18 Dec 2008 12:51:29 -0600
References: <21070179.post@talk.nabble.com>
	<20081218160256.GA14419@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 18, 2008, at 10:02 AM, Anton Vorontsov wrote:

> On Thu, Dec 18, 2008 at 02:29:52AM -0800, Felix Radensky wrote:
>>
>> Hi,
>>
>> I'm experiencing a long (around 20 sec) delay from the moment
>> u-boot-1.3.4 passes control to linux and until the first kernel  
>> message
>> appears on console.
>
> I saw somewhat similar behaviour on 83xx target, the cause was
> that my .config file contained bogus UDBG_RTAS_CONSOLE=y symbol
> (or was it PPC_EARLY_DEBUG_RTAS_PANEL=y? Or HVC_UDBG=y? I don't
> quite remember).
>
> Obviously, on 83xx we don't have RTAS or HVC stuff, but kernel
> didn't oops or hang completely, it was busy with executing various
> delays in those drivers and then just continued to load.

Why are these drivers even doing anything on 83xx?  Seems like they  
need something to bind against or some detection of "HW".

- k
