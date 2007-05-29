Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED4ABDDEDF
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 16:44:17 +1000 (EST)
In-Reply-To: <20070529060541.GG30266@localhost.localdomain>
References: <20070529060541.GG30266@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c7c131c3a7fdf7727d9ea1e40775017a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Date: Tue, 29 May 2007 08:43:38 +0200
To: David Gibson <dwg@au1.ibm.com>
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +		MDIO: mdio@6000 {
>  			device_type = "mdio";
> -			compatible = "tsi-ethernet";
> +			compatible = "tsi-mdio";

Hrm, did I miss this before?  A more exact "compatible"
property would be better ("tsi109-mdio" "tsi108-mdio" or
something like that).

Rest looks good,


Segher
