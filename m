Return-Path: <B32579@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E1526B6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 21:22:31 +1000 (EST)
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH] powerpc/85xx: Save and restore pcie ATMU windows for PM
Date: Thu, 19 May 2011 11:22:03 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F8741D5C33@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1303972729-32242-1-git-send-email-prabhakar@freescale.com>
	<3A8FAEED-7BD9-4776-85A9-560D07417BA8@kernel.crashing.org>
In-Reply-To: <3A8FAEED-7BD9-4776-85A9-560D07417BA8@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "meet2prabhu@gmail.com" <meet2prabhu@gmail.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Jiang Yutang-B14898 <B14898@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,
  Please find my answer in-lined

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Thursday, May 19, 2011 12:00 PM
> To: Kushwaha Prabhakar-B32579
> Cc: linuxppc-dev@lists.ozlabs.org; meet2prabhu@gmail.com; Jiang Yutang-
> B14898
> Subject: Re: [PATCH] powerpc/85xx: Save and restore pcie ATMU windows for
> PM
>=20
>=20
> On Apr 28, 2011, at 1:38 AM, Prabhakar Kushwaha wrote:
>=20
> > D3-cold state indicates removal of the clock and power. however
> > auxiliary (AUX) Power may remain available even after the main power
> rails are powered down.
> >
> > wakeup from D3-cold state requires full context restore. Other things
> > are taken care in pci-driver except ATMUs.
> > ATMU windows needs to be saved and restored during suspend and resume.
> >
> > Signed-off-by: Jiang Yutang <b14898@freescale.com>
> > Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> > ---
> > Based upon
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(b
> > ranch master)
> >
> > arch/powerpc/sysdev/fsl_pci.c |  116
> +++++++++++++++++++++++++++++++++++++++++
> > arch/powerpc/sysdev/fsl_pci.h |    7 ++-
> > 2 files changed, 121 insertions(+), 2 deletions(-)
>=20
> Is this patch for when we are a host or agent?

This patch is independent of host or agent. It is for supporting D3 cold st=
ate for P1022.
These functions are called during System level suspend and resume.=20

--Prabhakar
