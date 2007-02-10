Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9FC48DDECD
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 13:08:11 +1100 (EST)
In-Reply-To: <20070210004704.GC8276@localhost.localdomain>
References: <Pine.LNX.4.61.0702091727290.791@ld0175-tx32.am.freescale.net>
	<20070210004704.GC8276@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F7DA9D5D-B489-48DA-A9A3-77B8A37395FF@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: Subject: [PATCH] Add support for the 8568 MDS board
Date: Fri, 9 Feb 2007 20:07:47 -0600
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 9, 2007, at 18:47, David Gibson wrote:

> On Fri, Feb 09, 2007 at 05:28:31PM -0600, Andy Fleming wrote:
> [snip]
>> +/ {
>> +	model = "MPC8568EMDS";
>> +	compatible = "MPC85xxMDS";
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	linux,phandle = <100>;
>> +
>> +	cpus {
>> +		#cpus = <1>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		linux,phandle = <200>;
>
> So, every Freescale device tree source I've seen so far has had these
> hardcoded phandles all through it.  dtc has supported
> reference-to-path to automatically generate the necessary phandles for
> ages now.  Please can we use it...

Ok, I'll take a look.  Any pointers on syntax?

Andy
