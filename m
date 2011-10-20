Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DF43B1007D1
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2011 07:56:02 +1100 (EST)
Subject: Re: [RFC][PATCH 2/2] powerpc/85xx: Introduce a P1020 SoC device tree
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOZdJXU4uHSTRD0vf2jS9gOzjVyO4BLn9=kEmLwwb72LhkTz=w@mail.gmail.com>
Date: Thu, 20 Oct 2011 15:56:09 -0500
Message-Id: <F31B0E37-BB2A-4C7A-8CB1-FCE55392A29B@kernel.crashing.org>
References: <1319095467-6229-1-git-send-email-galak@kernel.crashing.org>
 <1319095467-6229-2-git-send-email-galak@kernel.crashing.org>
 <CAOZdJXU4uHSTRD0vf2jS9gOzjVyO4BLn9=kEmLwwb72LhkTz=w@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 20, 2011, at 11:28 AM, Tabi Timur-B04825 wrote:

> On Thu, Oct 20, 2011 at 2:24 AM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>>=20
>>  arch/powerpc/boot/dts/p1020soc.dtsi |  262 =
+++++++++++++++++++++++++++++++++++
>=20
> All of the other dtsi files are of the format "___si.dtsi".  Why does
> this one use "___soc.dtsi"?

I intend to also have a ___si.dtsi, still playing around with this so we =
have less overall duplication to support both 32 & 36-bit address maps =
as an example.

- k=
