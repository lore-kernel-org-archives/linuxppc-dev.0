Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2FE95B731F
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 06:23:57 +1100 (EST)
Subject: Re: [PATCH] powerpc/fsl-booke: Add e500mc smp defconfig
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AANLkTinJq78ZQbW_r0mJqA884-Mt+a_m6pJSLn-PAGuT@mail.gmail.com>
Date: Tue, 15 Mar 2011 14:23:52 -0500
Message-Id: <6D420108-4C51-47C0-896F-80C69F2C725F@kernel.crashing.org>
References: <1287062710-8621-1-git-send-email-galak@kernel.crashing.org>
	<AANLkTinJq78ZQbW_r0mJqA884-Mt+a_m6pJSLn-PAGuT@mail.gmail.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 14, 2010, at 8:51 AM, Timur Tabi wrote:

> On Thu, Oct 14, 2010 at 8:25 AM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>=20
>> +CONFIG_MATH_EMULATION=3Dy
>=20
> Don't these chips have hardware FP?

removed.

>=20
>> +CONFIG_E1000=3Dy
>> +CONFIG_E1000E=3Dy
>=20
> Are you sure you want these on by default?  We may use the E1000 cards
> in-house, but I don't know if our customers do.

leaving, customers can always disable

>> +CONFIG_MSDOS_FS=3Dm
>> +CONFIG_VFAT_FS=3Dy
>> +CONFIG_NTFS_FS=3Dy

leaving since we deal with USB flashes and MMC cards which could be =
MSDOS, VFAT, etc.

- k=
