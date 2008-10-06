Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 511B5DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 02:10:21 +1100 (EST)
Message-Id: <9509FE83-529D-4C0B-B226-B7169FA727DB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Leon Woestenberg" <leon.woestenberg@gmail.com>
In-Reply-To: <c384c5ea0810060642l2bbc2a08y5725a28b6d45aa8d@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: MPC8315ERDB PCI Express support status?
Date: Mon, 6 Oct 2008 10:09:47 -0500
References: <c384c5ea0810060642l2bbc2a08y5725a28b6d45aa8d@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Tony Li <Tony.Li@freescale.com>,
	Stuart Hughes <seh@zee2.com>,
	Jerry Huang <Chang-Ming.Huangcm@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 6, 2008, at 8:42 AM, Leon Woestenberg wrote:

> Hello all,
>
>
> can Freescale or any of the powerpc maintainers indicate to what
> extend PCI Express support for the MPC8315E processor has been merged
> to Linux mainline, or what is still needs review or attention?
>
> I could find u-boot and Linux patches provided by Freescale in their
> open-source patch pool:
>
> http://www.bitshrine.org/gpp/
> http://www.bitshrine.org/gpp/linux-fsl-2.6.24.3-MPC8315ERDB-pcie-INTx-support.patch
>
> but I could not easily identify what has been merged upstream.
>
>
> My first goal (and hardware on my desk) would be to test an Intel PCIe
> PRO/1000 Ethernet adapter, as a start to add a custom PCIe FPGA
> device.

No PCI-e support for 83xx has been merged in any mainline kernel.

- k
