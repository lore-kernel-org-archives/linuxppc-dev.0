Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6EFB3DE061
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 00:01:32 +1000 (EST)
Message-Id: <08C844E9-A768-4EF0-83D5-61BA408B80C8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <4847AD42.1000201@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH v2 2/4] [POWERPC] 85xx: support for the TQM8548 module
	using the big Flash
Date: Thu, 5 Jun 2008 09:01:11 -0500
References: <4847AD42.1000201@grandegger.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 5, 2008, at 4:09 AM, Wolfgang Grandegger wrote:

> Some TQM85xx boards could be equipped with up to 1 GiB (NOR) flash
> memory and therefore a modified memory map is required and setup by
> the board loader. This patch adds an appropriate DTS file.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
> arch/powerpc/boot/dts/tqm8548-bigflash.dts |  368 +++++++++++++++++++ 
> ++++++++++
> 1 file changed, 368 insertions(+)
> create mode 100644 arch/powerpc/boot/dts/tqm8548-bigflash.dts

similar comments as to the base tqm8548.dts

also is it not possible to deal w/the differences in u-boot itself?

- k
