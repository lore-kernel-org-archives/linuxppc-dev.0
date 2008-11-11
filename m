Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B547DDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Nov 2008 08:47:01 +1100 (EST)
In-Reply-To: <4919DB5E.9090508@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Using DMA
MIME-Version: 1.0
Message-ID: <OFA4A29B19.15508F00-ON882574FE.0075F65A-882574FE.00779C47@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Tue, 11 Nov 2008 13:46:51 -0800
Content-Type: text/plain; charset="US-ASCII"
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

Timur Tabi <timur@freescale.com> wrote on 11/11/2008 11:22:06 AM:

> Bruce_Leonard@selinc.com wrote:
> 
>          soc8349@e0000000 {
>                  #address-cells = <1>;
>                  #size-cells = <1>;
>                  #interrupt-cells = <2>;
>                  device_type = "soc";
> +                compatible = "simple-bus";
> 
> 
> And then add
> 
>        { .compatible = "simple-bus", },
> 
> to your struct of_device_id array.
> 
> -- 
> Timur Tabi
> Linux kernel developer at Freescale

Yea, that works!  I hit the probe function.  Thanks very much Timur.  I 
would never have found that.

Experimentally, I've found that I don't need the "simple-bus" 
compatibility in the of_device_id array in the Elo DMA driver.  Any idea 
why?

Thanks again for all the help.  If you've got some time, could you explain 
why adding the "simple-bus" compatibility to the SOC node of the device 
tree was needed.  I _still_ (after fighting with them for over a year) 
don't get device trees.

Bruce
