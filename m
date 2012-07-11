Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 77BB52C04AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 22:58:08 +1000 (EST)
Subject: Re: [PATCH v2 1/3] powerpc/fsl-pci: get PCI init out of board files
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341966409-22660-2-git-send-email-scottwood@freescale.com>
Date: Wed, 11 Jul 2012 07:58:01 -0500
Message-Id: <3031A8CE-6749-4ED8-96BA-54C449A48F31@kernel.crashing.org>
References: <1341966409-22660-1-git-send-email-scottwood@freescale.com>
 <1341966409-22660-2-git-send-email-scottwood@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 10, 2012, at 7:26 PM, Scott Wood wrote:

> As an alternative incremental starting point to Jia Hongtao's =
patchset,
> get the FSL PCI init out of the board files, but do not yet convert to =
a
> platform driver.
>=20
> Rather than having each board supply a magic register offset for
> determining the "primary" bus, we look for which PCI host bridge
> contains an ISA node within its subtree.  If there is no ISA node,
> normally that would mean there is no primary bus, but until certain
> bugs are fixed we arbitrarily designate a primary in this case.
>=20
> Conversion to a platform driver and related improvements can happen
> after this, as the ordering issues are sorted out.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> v2: rebased on Kumar's next
>=20
> arch/powerpc/sysdev/fsl_pci.c |   71 =
++++++++++++++++++++++++++++++++++++++++-
> arch/powerpc/sysdev/fsl_pci.h |    8 +++++
> 2 files changed, 78 insertions(+), 1 deletions(-)

applied to next

- k=
