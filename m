Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 80984DDF06
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 09:26:41 +1100 (EST)
Message-ID: <47E2E4A2.9000801@freescale.com>
Date: Thu, 20 Mar 2008 17:26:42 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: DTS question
References: <20080320173302.7075a1d9@lappy.seanm.ca>
	<20080320181926.2ff7e297@lappy.seanm.ca>
In-Reply-To: <20080320181926.2ff7e297@lappy.seanm.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sean MacLennan wrote:
> Ok, here is what I did....
> 
> IIC0: i2c@ef600700 {
> 	compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic"; 
> 	reg = <ef600700 14>; 
> 	interrupt-parent = <&UIC0>;
> 	interrupts = <2 4>;
> 	index = <0>;
> 
> 	ad7414 {
> 		compatible = "ad7414";

This should proabably have a manufacturer prefix.

> 		interrupts = <19 8>;
> 		interrupt-parent = <&UIC0>;
> 	};

Should have a reg property indicating the i2c address, and 
#address-cells = <1>/#size-cells = <0> in the i2c controller node.

-Scott
