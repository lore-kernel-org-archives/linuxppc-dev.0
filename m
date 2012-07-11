Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 73F9F2C02BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 00:53:45 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc/85xx: Create dts of each core in CAMP mode
 for P1021RDB-PC
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4FFD9281.1070202@freescale.com>
Date: Wed, 11 Jul 2012 09:53:38 -0500
Message-Id: <21405BDD-2124-4CB6-A947-0B8124D51063@kernel.crashing.org>
References: <1341909561-6591-1-git-send-email-Jiucheng.Xu@freescale.com>
 <1341909561-6591-2-git-send-email-Jiucheng.Xu@freescale.com>
 <CAOZdJXX1+=p3GMccLvCwFpei2igidXuo_U1gSVy56cBAkKxoHg@mail.gmail.com>
 <4D91E39B-2773-429D-B956-38C04521C8B2@kernel.crashing.org>
 <4FFD9281.1070202@freescale.com>
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


On Jul 11, 2012, at 9:49 AM, Timur Tabi wrote:

> Kumar Gala wrote:
>> Since we already have P1021RDB-PC w/AMP support in upstream I agree =
we don't need another example on P1021RDB-PC.
>=20
> Would you accept a patch that removes all AMP device trees from =
upstream?
> I just don't think that these very customer-specific dts files belong
> upstream.

No, I think we should have at least one or two examples of AMP dts in =
upstream.

- k=
