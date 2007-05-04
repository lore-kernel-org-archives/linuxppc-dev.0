Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 561CADDECF
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 13:08:56 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l453Agg11925374
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 13:10:42 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l453CQxR155312
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 13:12:26 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4538s3c003799
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 13:08:54 +1000
Date: Sat, 5 May 2007 09:51:11 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] Holly DTS
Message-ID: <20070504235111.GA19615@localhost.localdomain>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<1178302560.3026.210.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1178302560.3026.210.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 04, 2007 at 01:16:00PM -0500, Josh Boyer wrote:
> Add Holly/Hickory DTS file

[...]
> +		mdio@6000 {
> +			name = "mdio";
> +			device_type = "mdio";
> +			compatible = "tsi-ethernet";
> +			ethernet-phy@6000 {
> +				name = "ethernet-phy";
> +				device_type = "ethernet-phy";
> +				reg = <6000 50>;
> +				phy-id = <1>;
> +				linux,phandle = <421>;

Kill the explicit phandles, please.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
