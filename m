Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D1944DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Nov 2008 06:22:18 +1100 (EST)
Message-ID: <4919DB5E.9090508@freescale.com>
Date: Tue, 11 Nov 2008 13:22:06 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Using DMA
References: <OF4D34202F.A1805BCF-ON882574FE.00641B07-882574FE.00649D3C@selinc.com>
In-Reply-To: <OF4D34202F.A1805BCF-ON882574FE.00641B07-882574FE.00649D3C@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bruce_Leonard@selinc.com wrote:

         soc8349@e0000000 {
                 #address-cells = <1>;
                 #size-cells = <1>;
                 #interrupt-cells = <2>;
                 device_type = "soc";
+                compatible = "simple-bus";


And then add

       { .compatible = "simple-bus", },

to your struct of_device_id array.

-- 
Timur Tabi
Linux kernel developer at Freescale
