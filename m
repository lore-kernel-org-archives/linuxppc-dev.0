Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E3CD3B6F8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Oct 2011 07:40:36 +1100 (EST)
Received: from mail88-ch1 (localhost.localdomain [127.0.0.1])	by
	mail88-ch1-R.bigfish.com (Postfix) with ESMTP id A4C441370166	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2011 20:40:31 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: =?iso-8859-1?Q?Einar_M=E1r_Bj=F6rgvinsson?= <Einar.Bjorgvinsson@marel.com>
Subject: Re: Enabling MBX in MPC5121
Date: Wed, 5 Oct 2011 20:39:43 +0000
Message-ID: <CAOZdJXWucXcr+i5ZWbD0quc98n=6xOL1Rosx6=XAx0Gdt4Vf0w@mail.gmail.com>
References: <76E1146DEE728E4E95C1C6D1EEA1DBA96F159623@GRBSR0004.marel.net>
In-Reply-To: <76E1146DEE728E4E95C1C6D1EEA1DBA96F159623@GRBSR0004.marel.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2011/9/30 Einar M=E1r Bj=F6rgvinsson <Einar.Bjorgvinsson@marel.com>:
> Hi all
>
> I am interested in enabling the GPU on the MPC5121 for 2d/3d acceleration=
.
> I've read some misleading informations about the status of support in Lin=
ux
> for this.
> What is the status today ? is it easily possible ? if so, how ?

There may be some support for the GPU in the BSP for the MPC5121, but
I don't think there's anything in the mainline kernel.

--=20
Timur Tabi
Linux kernel developer at Freescale=
