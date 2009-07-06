Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BF388B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 06:14:46 +1000 (EST)
Message-ID: <4A525B4C.5050600@freescale.com>
Date: Mon, 06 Jul 2009 15:15:08 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Subject: Re: RAMDISK on EP88xc
References: <97dd5fd20907011104t773c3fc9tca7f0fe56ea22477@mail.gmail.com>
	<97dd5fd20907020927v2680a7f8m2657193394bd6323@mail.gmail.com>
	<97dd5fd20907021142i663de6aavc093fbd6ac5025c@mail.gmail.com>
	<1ba63b520907021338n3c0d6d33g11d4934ccc538a94@mail.gmail.com>
	<97dd5fd20907021438ve8c72b9g168e4aa22e9f2f9f@mail.gmail.com>
	<4A4D2B70.1030505@freescale.com>
	<97dd5fd20907061129k67d2404m7e2a2c8fd8a71503@mail.gmail.com>
	<4A5244B6.7030800@freescale.com>
	<97dd5fd20907061150o303418a3m3967650433fbb061@mail.gmail.com>
	<4A524A24.2010206@freescale.com>
	<97dd5fd20907061228v131149c8ue5c3a02f6084e171@mail.gmail.com>
In-Reply-To: <97dd5fd20907061228v131149c8ue5c3a02f6084e171@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mikhail Zaturenskiy wrote:
>>> +       CONFIG_BLK_DEV = y
>> Hmm, missed this.  I'm not sure why the subsequent changes didn't take
>> effect -- what did the .config look like after sucking in the defconfig
>> changes, but without any Kconfig changes?
> 
> I reverted back all the Kconfig changes and made the changes just in
> ep88xc_defconfig. See attached files for details, (didn't want a
> mile-long email).
> 
> Does this tell you anything?

CONFIG_BLK_DEV is enabled in that output.  That was the only change that 
I saw you make to the config in the previous e-mail -- no 
CONFIG_BLK_DEV_RAM, etc:

> ****************************************************
> in arch/powerpc/configs/ep88xc_defconfig:
> +	CONFIG_BLK_DEV = y
> -	CONFIG_BLK_DEV is not set
> -	CONFIG_BLK_DEV_INITRD is not set
> -	CONFIG_EXT2_FS is not set

-Scott
