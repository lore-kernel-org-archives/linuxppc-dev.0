Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05EFE1A0E18
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 01:30:19 +1100 (AEDT)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0101.outbound.protection.outlook.com [65.55.169.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1BE2E1402AC
 for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2015 01:30:17 +1100 (AEDT)
Message-ID: <54CB917E.7080101@Freescale.com>
Date: Fri, 30 Jan 2015 08:13:18 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>
Subject: Re: [v5, 5/6] powerpc/mpc85xx: Add FSL QorIQ DPAA BMan support to
 device tree(s)
References: <1418034561-12034-6-git-send-email-Emilian.Medve@Freescale.com>
 <20150130050318.GA12890@home.buserror.net>
In-Reply-To: <20150130050318.GA12890@home.buserror.net>
Content-Type: text/plain; charset="windows-1252"
Cc: linuxppc-dev@ozlabs.org, Geoff Thorpe <Geoff.Thorpe@Freescale.com>,
 Chunhe Lan <Chunhe.Lan@Freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@Freescale.com>, devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 01/29/2015 11:03 PM, Scott Wood wrote:
> On Mon, Dec 08, 2014 at 04:29:20AM -0600, Emil Medve wrote:
>> From: Kumar Gala <galak@kernel.crashing.org>
>>
>> Change-Id: If643fa5ba0a903aef8f5056a2c90ebecc995b760
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
>> Signed-off-by: Hai-Ying Wang <Haiying.Wang@freescale.com>
>> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
>> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
>> [Emil Medve: Sync with the upstream binding]
>> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> 
> Doesn't apply cleanly
> 
>> @@ -408,6 +415,8 @@ crypto: crypto@300000 {
>>  		fsl,iommu-parent = <&pamu1>;
>>  	};
>>  
>> +/include/ "qoriq-bman1.dtsi"
>> +
>>  /include/ "qoriq-fman-0.dtsi"
>>  /include/ "qoriq-fman-0-1g-0.dtsi"
>>  /include/ "qoriq-fman-0-1g-1.dtsi"
> 
> What tree did you base these patches on?  There's no fman in the upstream
> device trees yet (just a binding).

They were based on this patch series:
http://patchwork.ozlabs.org/patch/370866. Will re-send


Cheers,
