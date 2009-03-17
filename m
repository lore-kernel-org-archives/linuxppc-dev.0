Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1A48DDEDD
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 00:57:00 +1100 (EST)
Message-Id: <0AF2700E-820D-4B45-B87C-2CF39185CCA6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegegr <wg@grandegger.com>
In-Reply-To: <1237281143-8768-1-git-send-email-wg@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 0/4] NAND: Multi-chip support for FSL-UPM for TQM8548
	modules
Date: Tue, 17 Mar 2009 08:56:44 -0500
References: <1237281143-8768-1-git-send-email-wg@grandegger.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 17, 2009, at 4:12 AM, Wolfgang Grandegegr wrote:

> The following patch series adds generic support for multi-chip NAND  
> devices
> to the FSL-UPM driver and support for the Micron MT29F8G08FAB NAND  
> flash
> memory on the TQM8548 modules:
>
> [PATCH 1/4] NAND: FSL-UPM: add multi chip support
> [PATCH 2/4] NAND: FSL-UPM: add support for selecting chips via MAR
> [PATCH 3/4] NAND: FSL-UPM: Add wait flags to support board/chip  
> specific delays
> [PATCH 4/4] powerpc/85xx: TQM8548: Update DTS file for multi-chip  
> support
>
> Wolfgang.

You need to update:

Documentation/powerpc/dts-bindings/fsl/upm-nand.txt

I see some new properties defined in this code and not documented ;)

- k
