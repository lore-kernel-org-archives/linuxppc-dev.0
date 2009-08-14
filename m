Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 02C1FB800A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Aug 2009 06:21:27 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59636DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2009 06:21:26 +1000 (EST)
Message-Id: <D6C55DFB-0675-429F-BAE9-1DAB02BA4DA2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <af988ab89523a12510ac715429df6551312d1a80.1250036189.git.paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 4/4] sbc8349: update defconfig, enable MTD, USB storage
Date: Fri, 14 Aug 2009 15:21:21 -0500
References: <1250084071-26418-1-git-send-email-paul.gortmaker@windriver.com>
	<87b9869d069308d2ed12324ea924e284c85a6765.1250036189.git.paul.gortmaker@windriver.com>
	<22f17c810cb3e567a842300c553121a574d9b139.1250036189.git.paul.gortmaker@windriver.com>
	<764194b0524e1baccb737668f5aeb198989ac2d1.1250036189.git.paul.gortmaker@windriver.com>
	<af988ab89523a12510ac715429df6551312d1a80.1250036189.git.paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 12, 2009, at 8:34 AM, Paul Gortmaker wrote:

> With flash partition entries in the DTS file, MTD might as well
> be enabled in the defconfig.  In a similar vein, enable USB and
> enough related options (SCSI/ext2/ext3) so that a user can read
> and write to a generic USB flash drive as well.
>
> Also, this board only has the two default SOC UARTs, so adjust the
> UART config accordingly.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/configs/83xx/sbc834x_defconfig |  320 ++++++++++++++++++ 
> ++++++++-
> 1 files changed, 308 insertions(+), 12 deletions(-)


applied to next

- k
