Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 99568679F6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 03:27:20 +1000 (EST)
In-Reply-To: <427F4D38.70102@intracom.gr>
References: <427F4D38.70102@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <89f1e01d28e3fd391c2c636707a02be1@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 9 May 2005 12:26:52 -0500
To: "Pantelis Antoniou" <panto@intracom.gr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH  01/04] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Any reason we dont allow this driver on 85xx?  (should be same as 82xx)

- kumar

On May 9, 2005, at 6:44 AM, Pantelis Antoniou wrote:

> Hi
>
> The following patch is a combined FCC/FEC ethernet driver
> for the Freescale line of PowerQUICCs.
>
> FECs on 8xx and FCCs on 82xx are supported.
>
> This part of the patch contains makefiles and friends.
>
> Regards
>
> Pantelis
>
> Signed-off-by: Pantelis Antoniou <panto@intracom.gr>
> <fs_enet-01.patch>
