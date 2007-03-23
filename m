Return-Path: <tnt@246tNt.com>
Received: from outmx015.isp.belgacom.be (outmx015.isp.belgacom.be
	[195.238.4.87])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF801DE012
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Mar 2007 22:57:03 +1100 (EST)
Received: from outmx015.isp.belgacom.be (localhost [127.0.0.1])
	by outmx015.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l2NBun1J022468
	for <linuxppc-embedded@ozlabs.org>; Fri, 23 Mar 2007 12:56:50 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4603C07F.4000007@246tNt.com>
Date: Fri, 23 Mar 2007 12:56:47 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH 3/5 v2] mpc52xx suspend: USB
References: <20070315103959.GA22215@moe.telargo.com>	<20070315104228.GD22215@moe.telargo.com>	<528646bc0703150624i2bac5ce4n7beebc88d8acbafe@mail.gmail.com>
	<20070322074443.GB4620@moe.telargo.com>
In-Reply-To: <20070322074443.GB4620@moe.telargo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Domen Puncer wrote:
> +	struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
> +	if (machine_is_compatible("generic-mpc5200")) {
> +		struct ohci_hcd *ohci = hcd_to_ohci(hcd);
>
>   
Not good, what if you have a Ohci PCI card on a 5200 board ...

You somehow need to check the compatible list of the of_node associated
with the particular instance you're putting to sleep.


    Sylvain
 
