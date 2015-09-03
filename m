Return-Path: <Suravee.Suthikulpanit@amd.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0095.outbound.protection.outlook.com [157.56.110.95])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 57DBF1A240C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2015 00:53:15 +1000 (AEST)
Subject: Re: [PATCH v3 4/4] arm64: dts: Drop linux,pci-probe-only from the
 Seattle DTS
To: Marc Zyngier <marc.zyngier@arm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Grant Likely <grant.likely@linaro.org>, "Rob
 Herring" <robh+dt@kernel.org>
References: <1441282576-7304-1-git-send-email-marc.zyngier@arm.com>
 <1441282576-7304-5-git-send-email-marc.zyngier@arm.com>
CC: Alexander Graf <agraf@suse.de>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Message-ID: <55E856FC.4040006@amd.com>
Date: Thu, 3 Sep 2015 21:19:40 +0700
MIME-Version: 1.0
In-Reply-To: <1441282576-7304-5-git-send-email-marc.zyngier@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Marc

On 9/3/2015 7:16 PM, Marc Zyngier wrote:
> The linux,pci-probe-only property mandates an argument to indicate
> whether or not to engage the "probe-only" mode, but the Seattle
> DTS just provides a naked property, which is illegal.
>
> Also, it turns out that the board is perfectly happy without
> probe-only, so let's drop this altogether.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm64/boot/dts/amd/amd-overdrive.dts | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/amd/amd-overdrive.dts b/arch/arm64/boot/dts/amd/amd-overdrive.dts
> index 564a3f7..128fa94 100644
> --- a/arch/arm64/boot/dts/amd/amd-overdrive.dts
> +++ b/arch/arm64/boot/dts/amd/amd-overdrive.dts
> @@ -14,7 +14,6 @@
>
>   	chosen {
>   		stdout-path = &serial0;
> -		linux,pci-probe-only;
>   	};
>   };
>
>

Thanks, I was planning to do this as well. The embedded DT in the UEFI 
FW will soon remove this property.

Acked-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Suravee
