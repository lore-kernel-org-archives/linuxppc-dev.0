Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4BD0F2C0193
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2012 00:05:07 +1100 (EST)
Subject: Re: [PATCH 1/4 v2] iommu/fsl: Store iommu domain information pointer
 in archdata.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D29AE62@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Wed, 28 Nov 2012 11:35:28 -0600
Message-Id: <93330D7F-0A5A-4C42-A10C-92D6C7694D44@kernel.crashing.org>
References: <1353419697-31269-1-git-send-email-Varun.Sethi@freescale.com>
 <1353419697-31269-2-git-send-email-Varun.Sethi@freescale.com>
 <C5ECD7A89D1DC44195F34B25E172658D29AE62@039-SN2MPN1-013.039d.mgd.msft.net>
To: Sethi Varun-B16395 <B16395@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "joerg.roedel@amd.com" <joerg.roedel@amd.com>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 25, 2012, at 11:33 PM, Sethi Varun-B16395 wrote:

> Hi Kumar,
> Can you please apply this patch.
>=20
> Regards
> Varun

Was waiting on the others to apply this all together.  (ie getting an =
Ack from Joerg, and follow comments from Timur to be resolved)

- k

>=20
>> -----Original Message-----
>> From: Sethi Varun-B16395
>> Sent: Tuesday, November 20, 2012 7:25 PM
>> To: joerg.roedel@amd.com; iommu@lists.linux-foundation.org; linuxppc-
>> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Wood =
Scott-B07421;
>> Tabi Timur-B04825
>> Cc: Sethi Varun-B16395
>> Subject: [PATCH 1/4 v2] iommu/fsl: Store iommu domain information =
pointer
>> in archdata.
>>=20
>> Add a new field in the device (powerpc) archdata structure for =
storing
>> iommu domain information pointer. This pointer is stored when the =
device
>> is attached to a particular domain.
>>=20
>> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
>> ---
>> arch/powerpc/include/asm/device.h |    4 ++++
>> 1 files changed, 4 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/device.h
>> b/arch/powerpc/include/asm/device.h
>> index 77e97dd..6dc79fe 100644
>> --- a/arch/powerpc/include/asm/device.h
>> +++ b/arch/powerpc/include/asm/device.h
>> @@ -28,6 +28,10 @@ struct dev_archdata {
>> 		void		*iommu_table_base;
>> 	} dma_data;
>>=20
>> +	/* IOMMU domain information pointer. This would be set
>> +	 * when this device is attached to an iommu_domain.
>> +	 */
>> +	void			*iommu_domain;
>> #ifdef CONFIG_SWIOTLB
>> 	dma_addr_t		max_direct_dma_addr;
>> #endif
>> --
>> 1.7.4.1
>=20
