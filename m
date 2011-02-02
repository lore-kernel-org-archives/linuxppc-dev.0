Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8220B70DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Feb 2011 18:46:02 +1100 (EST)
Subject: Re: [PATCH V2 3/6] powerpc/47x: allow kernel to be loaded in higher
	physical memory
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1296586126-32765-4-git-send-email-shaggy@linux.vnet.ibm.com>
Date: Wed, 2 Feb 2011 01:45:48 -0600
Message-Id: <7637207D-0D0C-4920-9E8D-B175711C1164@kernel.crashing.org>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-4-git-send-email-shaggy@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 1, 2011, at 12:48 PM, Dave Kleikamp wrote:

> Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> arch/powerpc/Kconfig                          |    2 +-
> arch/powerpc/configs/44x/iss476-smp_defconfig |    6 ++--
> arch/powerpc/kernel/head_44x.S                |   42 =
++++++++++++++++++++-----
> arch/powerpc/mm/44x_mmu.c                     |   13 ++++++--
> 4 files changed, 48 insertions(+), 15 deletions(-)

Would be nice to expand in the commit message on what "higher physical" =
means.

- k=
