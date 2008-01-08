Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E6715DDE98
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 12:16:05 +1100 (EST)
Message-ID: <4782CED3.2050307@pikatech.com>
Date: Mon, 07 Jan 2008 20:16:03 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] i2c-ibm_iic driver
References: <477EF225.4070505@pikatech.com> <200801051224.52693.arnd@arndb.de>
In-Reply-To: <200801051224.52693.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> If there is a good reason to specify fast or slow mode per board, you may want
> to make that a property in the device node.
>   
I tried to add fast_mode to the .dts file and failed.

            IIC1: i2c@ef600800 {
                device_type = "i2c";
                compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
                reg = <ef600800 14>;
                interrupt-parent = <&UIC0>;
                interrupts = <7 4>;
                fast-mode = <0>;
            };

As soon as a I add the fast-mode line I get the following error on boot:

fdt_wrapper_setprop():105  FDT_ERR_NOSPACE

Remove the line and I boot. Any ideas?

Cheers,
   Sean
