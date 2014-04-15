Return-Path: <martijn.de.gouw@prodrive-technologies.com>
Received: from mail.prodrive.nl (mail.prodrive.nl [212.61.153.67])
 by ozlabs.org (Postfix) with ESMTP id 15202140093
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 21:24:42 +1000 (EST)
Message-ID: <534D16F6.9090305@prodrive-technologies.com>
Date: Tue, 15 Apr 2014 13:24:38 +0200
From: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: Add OCA4080 board support
References: <1397478910-26361-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
 <1397514507.20280.223.camel@snotra.buserror.net>
In-Reply-To: <1397514507.20280.223.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: stef.van.os@prodrive-technologies.com,
 Martijn de Gouw <martijn.de.gouw@prodrive.nl>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/15/2014 12:28 AM, Scott Wood wrote:
> On Mon, 2014-04-14 at 14:35 +0200, Martijn de Gouw wrote:
>> +	lbc: localbus@ffe124000 {
>> +		reg = <0xf 0xfe124000 0 0x1000>;
>> +		ranges = <0 0 0xf 0xef800000 0x800000>;
>> +
>> +		flash@0,0 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			compatible = "cfi-flash";
>> +			reg = <0 0 0x00800000>;
>> +			bank-width = <2>;
>> +			device-width = <2>;
>> +			partition@rcw {
>> +				label = "rcw";
>> +				reg = <0x00000000 0x00020000>;
>> +			};
>> +			partition@fman-ucode {
>> +				label = "fman-ucode";
>> +				reg = <0x00020000 0x00020000>;
>> +			};
>> +			partition@user {
>> +				label = "user";
>> +				reg = <0x00040000 0x00680000>;
>> +			};
>> +			partition@env0 {
>> +				label = "env0";
>> +				reg = <0x006c0000 0x00020000>;
>> +			};
>> +			partition@env1 {
>> +				label = "env1";
>> +				reg = <0x006e0000 0x00020000>;
>> +			};
>> +			partition@u-boot {
>> +				label = "u-boot";
>> +				reg = <0x00700000 0x00080000>;
>> +			};
>> +			partition@u-boot-backup {
>> +				label = "u-boot-backup";
>> +				reg = <0x00780000 0x00080000>;
>> +			};
>
> These are not valid unit addresses.  Regardless, please don't put
> partition info in the dts.

How is this different than the partitions defined in i.e. p4080ds.dts?
Of course I can remove them from the dts, but where should they be defined?

-- 
Martijn de Gouw
Engineer
Prodrive Technologies B.V.
Mobile: +31 63 17 76 161
Phone:  +31 40 26 76 200
