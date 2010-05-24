Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B045B7D88
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 May 2010 05:13:00 +1000 (EST)
Subject: Re: [PATCH v3 3/5] fsl_msi: enable msi sharing through AMP OSes
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1271925099-29100-3-git-send-email-leoli@freescale.com>
Date: Mon, 24 May 2010 14:12:53 -0500
Message-Id: <3DAF51B2-7C1E-45C3-BE76-C3AE3B0519D3@kernel.crashing.org>
References: <1271925099-29100-1-git-send-email-leoli@freescale.com>
	<1271925099-29100-2-git-send-email-leoli@freescale.com>
	<1271925099-29100-3-git-send-email-leoli@freescale.com>
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Zhao Chenhui <b26998@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 22, 2010, at 3:31 AM, Li Yang wrote:

> Make a single PCIe MSI bank shareable through CAMP OSes. The number of
> MSI used by each core can be configured by dts file.
> 
> Signed-off-by: Zhao Chenhui <b26998@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_msi.c |    8 +++++++-
> 1 files changed, 7 insertions(+), 1 deletions(-)

applied to next

- k
