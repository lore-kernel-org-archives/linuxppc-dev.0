Return-Path: <chuck@ThePTRGroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.178.251.9])
	by ozlabs.org (Postfix) with ESMTP id 3D804B6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Jun 2010 07:28:03 +1000 (EST)
Received: from [10.11.13.50] (unknown [10.11.13.50])
	by mail.theptrgroup.com (Postfix) with ESMTP id 6B3641E002
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 17:28:01 -0400 (EDT)
Message-ID: <4C212ADA.3070409@ThePTRGroup.com>
Date: Tue, 22 Jun 2010 17:27:54 -0400
From: Chuck Meade <chuck@ThePTRGroup.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: UCC UART
References: <4C20CECB.9050609@mlbassoc.com>	<4C20D27D.5000503@ThePTRGroup.com>	<4C20D34A.80202@mlbassoc.com>	<4C20D699.1080404@ThePTRGroup.com>	<4C20DABA.5030301@mlbassoc.com>	<4C20DC5F.80902@ThePTRGroup.com>	<4C20F671.9090605@mlbassoc.com>	<4C20FDA0.5050208@ThePTRGroup.com>	<4C2103DE.6020801@mlbassoc.com>
	<4C210892.3040503@ThePTRGroup.com> <4C2128E6.7010201@mlbassoc.com>
In-Reply-To: <4C2128E6.7010201@mlbassoc.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Also in the current Linux kernel, there is a dependence on the
>> correctness
>> of the "brg-frequency" property from the dts.  Look up above
>> qe_setbrg() at
>> the qe_get_brg_clk() function.  Before the return (there are multiple
>> return
>> points) printk the brg_clk being returned.  That must be correct for your
>> hardware -- must be the actual brg freq.  I assume that you are
>> booting from
>> U-Boot.  I believe in modern implementations that U-Boot fills in the
>> brg-frequency in the device tree at boot time.
> 
> The driver claims to work with either bus-frequency or brg-frequency set.
> I only had bus-frequency; when I set brg-frequency, it has started to work.
> Now to test it with a scope to see what else is wrong...
> 
> BTW, I use RedBoot - being the original author, how could I not?
> 
> Thanks for the help

No problem -- I am glad it is working for you now.

Chuck Meade
chuck@ThePTRGroup.com
