Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 8362467A7B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 01:36:06 +1000 (EST)
From: Jon Loeliger <jdl@freescale.com>
To: Li Yang-r58472 <LeoLi@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD46730117355F@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD46730117355F@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Message-Id: <1112283360.23088.57.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 31 Mar 2005 09:36:00 -0600
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: RE: Problem running Linux 2.6.11 on MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-03-31 at 02:22, Li Yang-r58472 wrote:
> Good point.
> There is also IMMR need to be passed from bootloader to kernel.  We
> can make more use of the u-boot bd_info mechanism.  But it binds ppc
> linux to u-boot boot loader.  I don't know if we should make it a
> porting convention.

Hi guys,

So, just for the record here, Kumar and I are moving the ppc32
line away from bd_t towards an OpenFirmware flattened device tree.
That data will still have a place for the IMMR to be passed.

Under another Subject:, I'll describe a brief outline of
The Plan So Far so people can take shots at it. :-)

> Best Regards,
> Leo

Thanks,
jdl
