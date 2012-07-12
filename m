Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8D5AF2C01F1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 13:16:44 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc/85xx: Create dts of each core in CAMP mode
 for P1021RDB-PC
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4FFD9439.2010901@freescale.com>
Date: Wed, 11 Jul 2012 22:16:42 -0500
Message-Id: <67BB61E8-A581-4863-A8B7-3A793E0225EE@kernel.crashing.org>
References: <1341909561-6591-1-git-send-email-Jiucheng.Xu@freescale.com>
 <1341909561-6591-2-git-send-email-Jiucheng.Xu@freescale.com>
 <CAOZdJXX1+=p3GMccLvCwFpei2igidXuo_U1gSVy56cBAkKxoHg@mail.gmail.com>
 <4D91E39B-2773-429D-B956-38C04521C8B2@kernel.crashing.org>
 <4FFD9281.1070202@freescale.com>
 <21405BDD-2124-4CB6-A947-0B8124D51063@kernel.crashing.org>
 <4FFD9439.2010901@freescale.com>
To: Timur Tabi <b04825@freescale.com>
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
 Xu Jiucheng-B37781 <B37781@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 11, 2012, at 9:56 AM, Timur Tabi wrote:

> Kumar Gala wrote:
>> No, I think we should have at least one or two examples of AMP dts in =
upstream.
>=20
> We have more than that:
>=20
> ./p2020rdb_camp_core1.dts
> ./p1020rdb-pc_camp_core1.dts
> ./mpc8572ds_camp_core1.dts
> ./p2020rdb_camp_core0.dts
> ./p1020rdb-pc_camp_core0.dts
> ./mpc8572ds_camp_core0.dts
> ./p1020rdb_camp_core1.dts
> ./p1020rdb_camp_core0.dts
>=20

I'd be ok if we want to drop the p1020rdb as that board has been =
replaced w/the p1020rdb-pc.

- k=
