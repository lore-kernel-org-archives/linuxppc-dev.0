Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 47D592C0177
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 01:21:27 +1000 (EST)
Subject: Re: [RFC][PATCH 2/2] powerpc/fsl-pci Make PCIe hotplug work with
 Freescale
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1636993.nIfPQTmF8g@pcimr>
Date: Wed, 10 Apr 2013 10:18:13 -0500
Message-Id: <9488E465-0205-430D-AC09-1A9000C864CE@kernel.crashing.org>
References: <1363201636-7318-1-git-send-email-galak@kernel.crashing.org>
 <2139831.oouZXZo4xk@pcimr>
 <CE155C19-35DF-4394-9608-BF923B5DA6EB@kernel.crashing.org>
 <1636993.nIfPQTmF8g@pcimr>
To: Rojhalat Ibrahim <imr@rtschenk.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 8, 2013, at 3:15 AM, Rojhalat Ibrahim wrote:

> Up to now the PCIe link status on Freescale PCIe controllers was only
> checked once at boot time. So hotplug did not work. With this patch =
the
> link status is checked on every config read. PCIe devices not present =
at
> boot time are found after doing 'echo 1 >/sys/bus/pci/rescan'.
>=20
> Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>
> ---
> arch/powerpc/include/asm/pci-bridge.h |    6 ++++
> arch/powerpc/sysdev/fsl_pci.c         |   51 =
+++++++++++++++++++++++++++++-----
> arch/powerpc/sysdev/indirect_pci.c    |   10 ++----
> 3 files changed, 54 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/pow

applied to next

- k=
