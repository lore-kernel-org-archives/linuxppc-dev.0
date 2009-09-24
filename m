Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7FD02B7B76
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 04:09:22 +1000 (EST)
Subject: Re: [PATCH] sbc8548: fixup of PCI-e related DTS fields
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1253543408-29706-1-git-send-email-paul.gortmaker@windriver.com>
Date: Thu, 24 Sep 2009 11:09:13 -0700
Message-Id: <4491154D-55DD-4935-B295-9E96D118E671@kernel.crashing.org>
References: <8549256E-05F8-4990-866F-EB73C048E462@kernel.crashing.org>
	<1253543408-29706-1-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 21, 2009, at 7:30 AM, Paul Gortmaker wrote:

> The PCI-e addressing was originally patterned of the MPC8548CDS
> which has PCI1, PCI2, and PCI-e.  Since this board only has
> PCI1 and PCI-e, it makes more sense to be similar to the MPC8568MDS
> board.  This does that by cutting the PCI/PCI-e I/O sizes from
> 16MB to 8MB and pulling the PCI-e I/O range back to 0xe280_0000
> (the hole where PCI2 I/O would have been).
>
> This also fixes a typo where an extra zero made an 8MB range a 128MB
> range, removes the hole left by PCI2 from the aliases, and sets the
> clocks to match the oscillators that are actually on the board.
>
> With accompanying u-boot updates, PCI-e has been validated with
> both a sky2 card (1148:9e00) and an e1000 card (8086:108b).
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>
> v2: cosmetic; fix leading zeros on 0x00800000 for better readability
>
> arch/powerpc/boot/dts/sbc8548.dts |   17 ++++++++---------
> 1 files changed, 8 insertions(+), 9 deletions(-)

applied to merge

- k
