Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CBC27B6F7A
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 14:12:19 +1000 (EST)
Subject: Re: [PATCH] Remove a BUG_ON that triggered when running under FSL
	Hypervisor
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1310046270-6654-1-git-send-email-Laurentiu.Tudor@freescale.com>
Date: Thu, 7 Jul 2011 23:12:11 -0500
Message-Id: <260B654A-B2A3-4E9C-932B-BC3E943DF6A5@kernel.crashing.org>
References: <1310046270-6654-1-git-send-email-Laurentiu.Tudor@freescale.com>
To: Laurentiu TUDOR <Laurentiu.Tudor@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 7, 2011, at 8:44 AM, Laurentiu TUDOR wrote:

> mpc85xx_smp_init platform init function assumed that smp_ops.message_pass
> was set to default arch dependent smp_muxed_ipi_message_pass.
> However this does not seem to happen. Moreover, the arch specific code
> in arch/powerpc/kernel/smp.c handles smp_ops.message_pass == NULL and if so
> calls the default implementation.
> 
> Signed-off-by: Laurentiu TUDOR <Laurentiu.Tudor@freescale.com>
> ---
> arch/powerpc/platforms/85xx/smp.c |    9 +++++----
> 1 files changed, 5 insertions(+), 4 deletions(-)

Re-worded commit message a bit, applied to next

- k
