Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26DA8DDE45
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 17:59:07 +1000 (EST)
Message-Id: <E50C84D1-E250-4827-B260-A5005CABE959@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081003070416.GA460@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: make Freescale QE support a selectable Kconfig
	option
Date: Fri, 3 Oct 2008 02:58:57 -0500
References: <1222961277-6166-1-git-send-email-timur@freescale.com>
	<20081003070416.GA460@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2008, at 2:04 AM, Anton Vorontsov wrote:

> On Thu, Oct 02, 2008 at 10:27:57AM -0500, Timur Tabi wrote:
>> Modify the Kconfig so that Freescale QUICC Engine (QE) support is a  
>> selectable
>> option, thereby allowing users to compile kernels without any QE  
>> support.
>>
>> The drawback is that QE support is now disabled by default on  
>> platforms that
>> have a QE, and so a defconfig is needed to enable QE and QE devices  
>> (like
>> UCC GETH).  Fortunately, all the current relevant defconfigs do  
>> that already.
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
>> ---
>
> [...]
>> config MPC836x_RDK
>> 	bool "Freescale/Logic MPC836x RDK"
>> 	select DEFAULT_UIMAGE
>> -	select QUICC_ENGINE
>> 	select QE_GPIO
>
> IIRC selects do not honor any dependencies, i.e. you should delete
> the QE_GPIO too.

Is QE_GPIO need by the board?  or you just enabled it to have it?

- k
