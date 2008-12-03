Return-Path: <sr@denx.de>
Received: from mout-xforward.kundenserver.de (mout-xforward.kundenserver.de
	[212.227.17.6]) by ozlabs.org (Postfix) with ESMTP id 128C4DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 16:49:05 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: u-boot@lists.denx.de
Subject: Re: [U-Boot] NAND only (no NOR)
Date: Wed, 3 Dec 2008 06:48:57 +0100
References: <4934F7FC.2030105@aimvalley.nl>
	<20081202215033.501f3403@lappy.seanm.ca>
In-Reply-To: <20081202215033.501f3403@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812030648.57618.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Norbert van Bolhuis <nvbolhuis@aimvalley.nl>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 03 December 2008, Sean MacLennan wrote:
> We use a 256M NAND on the PIKA Warp appliance and where unable to boot
> u-boot from the NAND. It worked on a smaller 64M NAND.

Currently you need to define the page-size of the NAND used for booting (512 
bytes vs. 2k). The 2k 4xx NAND booting support is was done about 1/2 a year 
ago. So perhaps you tested this when this 2k support was not available yet.

> So we put our FPGA and u-boot in a small NOR. The kernel, rootfs and
> other files are on the NAND.

Yes, I would recommend to do it this way if possible. A small NOR for U-Boot 
and environment and everything else in NAND. This makes things much easier. 
But I understand that this is sometimes a problem with space (2 FLASH chips) 
and costs.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
