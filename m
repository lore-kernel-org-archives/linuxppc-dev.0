Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 332152C02A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 02:46:47 +1100 (EST)
Subject: Re: [PATCH 3/6] powerpc/fsl_pci: Added defines for the FSL PCI
 controller BRR1 register.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20130227113336.GI26252@8bytes.org>
Date: Thu, 28 Feb 2013 09:46:51 -0600
Message-Id: <414263AA-3E4B-4748-AD06-94F869261841@kernel.crashing.org>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
 <1361191939-21260-4-git-send-email-Varun.Sethi@freescale.com>
 <20130227113336.GI26252@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, stuart.yoder@freescale.com,
 iommu@lists.linux-foundation.org, scottwood@freescale.com,
 Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 27, 2013, at 5:33 AM, Joerg Roedel wrote:

> On Mon, Feb 18, 2013 at 06:22:16PM +0530, Varun Sethi wrote:
>> Macros for checking FSL PCI controller version.
>>=20
>> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
>> ---
>> arch/powerpc/include/asm/pci-bridge.h |    4 ++++
>> 1 files changed, 4 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/pci-bridge.h =
b/arch/powerpc/include/asm/pci-bridge.h
>> index 025a130..c12ed78 100644
>> --- a/arch/powerpc/include/asm/pci-bridge.h
>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>> @@ -14,6 +14,10 @@
>>=20
>> struct device_node;
>>=20
>> +/* FSL PCI controller BRR1 register */
>> +#define PCI_FSL_BRR1      0xbf8
>> +#define PCI_FSL_BRR1_VER 0xffff
>> +
>=20
>=20
> Please merge this patch with the one where you actually make use of
> these defines for the first time.
>=20
>=20
> 	Joerg

This also seems an odd place for these defines.

- k=
