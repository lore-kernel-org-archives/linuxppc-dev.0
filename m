Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BA981A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 18:54:19 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0113.outbound.protection.outlook.com [157.56.111.113])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7F0651400DE
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2014 18:54:17 +1100 (AEDT)
Message-ID: <547EC183.2070005@Freescale.com>
Date: Wed, 3 Dec 2014 01:53:39 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>
Subject: Re: [PATCH v3 3/4] powerpc/mpc85xx: Add FSL QorIQ DPAA BMan support
 to device tree(s)
References: <1417428135-12895-1-git-send-email-Emilian.Medve@Freescale.com>
 <1417428135-12895-4-git-send-email-Emilian.Medve@Freescale.com>
 <1417566777.15957.227.camel@freescale.com>
In-Reply-To: <1417566777.15957.227.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
Cc: devicetree@vger.kernel.org, Poonam Aggrwal <poonam.aggrwal@Freescale.com>,
 Geoff Thorpe <Geoff.Thorpe@Freescale.com>, linuxppc-dev@ozlabs.org,
 Chunhe Lan <Chunhe.Lan@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 12/02/2014 06:32 PM, Scott Wood wrote:
> On Mon, 2014-12-01 at 04:02 -0600, Emil Medve wrote:
>> diff --git a/arch/powerpc/boot/dts/t4240rdb.dts b/arch/powerpc/boot/dts/t4240rdb.dts
>> index 53761d4..431bf4e 100644
>> --- a/arch/powerpc/boot/dts/t4240rdb.dts
>> +++ b/arch/powerpc/boot/dts/t4240rdb.dts
>> @@ -69,10 +69,27 @@
>>  		device_type = "memory";
>>  	};
>>  
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		bman_fbpr: bman-fbpr {
>> +			compatible = "fsl,bman-fbpr";
>> +			alloc-ranges = <0 0 0xffff 0xffffffff>;
>> +			size = <0 0x1000000>;
>> +			alignment = <0 0x1000000>;
>> +		};
>> +	};
> 
> Can't this be done at the SoC level rather than board level?

The size of the memory is not SoC specific. Among other things is
determined by the number of MACs that are pinned-out on the board


Cheers,
