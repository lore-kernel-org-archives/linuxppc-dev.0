Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ECA18DDFD5
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:46:17 +1100 (EST)
Message-Id: <F3EB7E01-46A4-4BD1-87BB-D8A292265522@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080125160820.GA7750@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v2] [POWERPC] 85xx: Port STX GP3 board over from arch/ppc
Date: Fri, 25 Jan 2008 10:23:21 -0600
References: <Pine.LNX.4.64.0801242245390.22024@blarg.am.freescale.net>
	<20080125160820.GA7750@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 25, 2008, at 10:08 AM, Scott Wood wrote:

> On Thu, Jan 24, 2008 at 10:47:21PM -0600, Kumar Gala wrote:
>> +	soc8560@fdf00000 {
>
> soc@fdf00000

will fix this up in the tqm port as well.

>
>
> -Scott
>> +		cpm@919c0 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			compatible = "fsl,mpc8560-cpm", "fsl,cpm2";
>
> This is also a simple-bus.

yeah, I realized I missed this.  Its fixed in my tree.
>
>
>> +static struct of_device_id __initdata of_bus_ids[] = {
>> +	{ .name = "soc", },
>> +	{ .type = "soc", },
>> +	{ .name = "cpm", },
>> +	{ .name = "localbus", },
>> +	{ .compatible = "simple-bus", },
>> +	{},
>> +};
>
> You should be able to get rid of the others besides simple-bus  
> (there may
> have been some confusion in what you asked over IRC yesterday -- I
> thought you were talking about compatible in the device tree, not  
> here).

yep :)

fixed and in the tqm port as well.

- k
