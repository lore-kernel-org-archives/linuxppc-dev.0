Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C18AE2C0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 22:18:55 +1000 (EST)
Subject: Re: [PATCH] powerpc/sgmii: Add phy nodes in SGMII mode
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A228F9@039-SN1MPN1-002.039d.mgd.msft.net>
Date: Thu, 12 Jul 2012 07:18:49 -0500
Message-Id: <56E7FB74-A29A-4658-9AC9-2C87A1A7ED3C@kernel.crashing.org>
References: <1342085776-13289-1-git-send-email-B38951@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A228F9@039-SN1MPN1-002.039d.mgd.msft.net>
To: Jia Hongtao-B38951 <B38951@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 12, 2012, at 5:28 AM, Jia Hongtao-B38951 wrote:

> Note that this patch works with uboot update.
> Please refer to:
> http://patchwork.ozlabs.org/patch/170627/
> 
> -Hongtao.

Will RGMII still work with this patch if I dont update u-boot?

I'm assuming yes.

- k

> 
>> -----Original Message-----
>> From: Jia Hongtao-B38951
>> Sent: Thursday, July 12, 2012 5:36 PM
>> To: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org
>> Cc: Li Yang-R58472; Jia Hongtao-B38951
>> Subject: [PATCH] powerpc/sgmii: Add phy nodes in SGMII mode
>> 
>> In SGMII riser card different PHY chip are used with different external
>> IRQ from eTSEC. To support PHY link state auto detect in SGMII mode we
>> should add another group of PHY nodes for SGMII mode.
>> 
>> For MPC8572DS IRQ6 is used for PHY0~PHY1, IRQ7 is used for PHY2~PHY3.
>> For MPC8544DS and MPC8536DS IRQ6 is used for PHY0~PHY1.
>> For P2020DS IRQ5 is used for PHY1~PHY2.
>> 
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
>> ---
>> arch/powerpc/boot/dts/mpc8536ds.dtsi |    8 ++++++++
>> arch/powerpc/boot/dts/mpc8544ds.dtsi |    9 +++++++++
>> arch/powerpc/boot/dts/mpc8572ds.dtsi |   17 +++++++++++++++++
>> arch/powerpc/boot/dts/p2020ds.dtsi   |   10 ++++++++++
>> 4 files changed, 44 insertions(+), 0 deletions(-)
>> 
> 
