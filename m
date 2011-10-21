Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D36B91007DF
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2011 14:03:22 +1100 (EST)
Subject: Re: [RFC][PATCH 1/2] powerpc/85xx: create dts components to build up
 an SoC
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4EA08D20.7010405@freescale.com>
Date: Thu, 20 Oct 2011 22:03:26 -0500
Message-Id: <06FA8EE7-85F8-42C6-A030-08E0A32763CB@kernel.crashing.org>
References: <1319095467-6229-1-git-send-email-galak@kernel.crashing.org>
 <CAOZdJXWtnBB5=DahG8LGQpeP7or0VZv78duhtPiORk3WOir8gQ@mail.gmail.com>
 <A54F7698-A96F-4EE1-89DB-B6A7C5A071FB@kernel.crashing.org>
 <4EA08D20.7010405@freescale.com>
To: Timur Tabi <timur@freescale.com>
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


On Oct 20, 2011, at 4:05 PM, Timur Tabi wrote:

> Kumar Gala wrote:
>>>> How about we put all serial devices into one pq3-duart.dtsi file, =
and
>>>> let the parent dtsi file reference just the ones that it needs?
>> there isn't an option to do that w/dtc
>=20
> What about making all the nodes disabled by default, and then the =
soc.dtsi
> or si.dtsi file can re-enable them?

Its still a bit problematic in that I don't want nodes to exist that =
aren't in the SoC.

- k=
