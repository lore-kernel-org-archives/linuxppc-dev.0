Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 3CAEEDE061
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 20:06:28 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: compile warning
Date: Tue, 30 Oct 2007 10:05:46 +0100
References: <1193405129.29250.2.camel@p60635-ste.ids.de>
	<77CDBB94-A21E-4A84-9818-4622CB2F572C@kernel.crashing.org>
	<1193730224.4997.13.camel@p60635-ste.ids.de>
In-Reply-To: <1193730224.4997.13.camel@p60635-ste.ids.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710301005.47598.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 30 October 2007, Sergej Stepanov wrote:

> -void
> +void __init
>  cpm2_reset(void)
>  {
>  #ifdef CONFIG_PPC_85xx
> 
> ------------------
> I am not sure it is ok.

Yes, this looks good.

> 
> But i have other 2 warnings (no modules).
> 
> WARNING: vmlinux.o(.exit.text+0x5da): Section mismatch: reference to
> .init.data:of_platform_serial_driver (between 'of_platform_serial_exit'
> and 'phy_exit')  
> WARNING: vmlinux.o(.exit.text+0x5e2): Section mismatch: reference to
> .init.data:of_platform_serial_driver (between 'of_platform_serial_exit' 
> and 'phy_exit')  

This seems to be my fault. I'll try to come up with the right fix.

	Arnd <><
