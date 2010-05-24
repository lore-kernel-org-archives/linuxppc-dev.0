Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2C938B6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 May 2010 05:12:43 +1000 (EST)
Subject: Re: [PATCH v3 1/5] fsl_msi: fix the conflict of virt_msir's chip_data
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1271925099-29100-1-git-send-email-leoli@freescale.com>
Date: Mon, 24 May 2010 14:12:37 -0500
Message-Id: <299762D3-D254-4717-A6F2-53782B1E872F@kernel.crashing.org>
References: <1271925099-29100-1-git-send-email-leoli@freescale.com>
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

> In fsl_of_msi_probe(), the virt_msir's chip_data have been stored
> the pointer to struct mpic. We add a struct fsl_msi_cascade_data
> to store the pointer to struct fsl_msi and msir_index in hanler_data.
> Otherwise, the pointer to struct mpic will be over-written, and will
> cause problem when calling eoi() of the irq.
> 
> Signed-off-by: Zhao Chenhui <b26998@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_msi.c |   33 +++++++++++++++++++++++++++------
> 1 files changed, 27 insertions(+), 6 deletions(-)

applied to next

- k
