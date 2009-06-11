Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C1FE6B7211
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 11:53:32 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D2ACDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 11:53:31 +1000 (EST)
Message-Id: <87E7BC96-041F-4244-8370-B8EE64EEDA7F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <1242155174-2513-1-git-send-email-wd@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] [PowerPC] MPC8272ADS: fix device tree for 8 MB flash size
Date: Wed, 10 Jun 2009 20:51:19 -0500
References: <1242155174-2513-1-git-send-email-wd@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 12, 2009, at 2:06 PM, Wolfgang Denk wrote:

> The current device tree for the MPC8272ADS assumes a mapping of 32 MB
> of NOR flash at 0xFE00.0000, while there are actually only 8 MB on
> the boards, mapped at 0xFF80.0000. When booting an uImage with such a
> device tree, the kernel crashes because 0xFE00.0000 is not mapped.
>
> Also introduce aliases for serial[01] and ethernet[01].
>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Scott Wood <scottwood@freescale.com>
> cc: Kumar Gala <galak@kernel.crashing.org>
> ---
> I am not really sure what the typical flash size on MPC8272ADS boards
> is. The board I used for testing is marked as "Prototype", so it may
> not be the release configuration. On the other hand, the manual also
> says 8 MB, Vitaly Borduk confirms 8 MB on his board, too, and Scott
> Wood eventually tested only with cuImage which fixes up the localbus
> mappings, thus eventually concealing the issue.
>
> I'm posting this as reference in case the 8 MB should turn out to be
> correct. -- wd
>
> arch/powerpc/boot/dts/mpc8272ads.dts |   19 +++++++++++++------
> 1 files changed, 13 insertions(+), 6 deletions(-)


applied to next.

- k
