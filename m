Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A770B6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Apr 2011 16:18:46 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Don't add disabled PCIe devices
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1301554869-31037-1-git-send-email-prabhakar@freescale.com>
Date: Tue, 5 Apr 2011 01:18:34 -0500
Message-Id: <A554F759-1D74-4FD8-A1CF-29B912C44F4F@kernel.crashing.org>
References: <1301554869-31037-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: meet2prabhu@gmail.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 31, 2011, at 2:01 AM, Prabhakar Kushwaha wrote:

> PCIe nodes with the property status=3D"disabled" are not usable and so
> avoid adding "disabled" PCIe bridge with the system.
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> Acked-by: Kumar Gala <kumar.gala@freescale.com>
> ---
> Based upon =
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branc=
h master)
>=20
> arch/powerpc/sysdev/fsl_pci.c |    5 +++++
> 1 files changed, 5 insertions(+), 0 deletions(-)

applied to merge

- k=
