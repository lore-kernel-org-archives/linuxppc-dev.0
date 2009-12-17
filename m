Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC0C0B6ED0
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 04:01:29 +1100 (EST)
Subject: Re: Problem with mini-PCI-E slot on P2020RDB
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0949C49693EF1A47A54B0F0113CDB4A60767F0@zin33exm23.fsl.freescale.net>
Date: Thu, 17 Dec 2009 11:01:11 -0600
Message-Id: <EBE3ECA5-AC1B-4E1C-A0DA-89260D0F03F6@kernel.crashing.org>
References: <4B27FEE3.80001@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A607674F@zin33exm23.fsl.freescale.net>	<4B28A7C3.6040209@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A6076776@zin33exm23.fsl.freescale.net>	<4B28CBC4.4010501@embedded-sol.com><0949C49693EF1A47A54B0F0113CDB4A6076791@zin33exm23.fsl.freescale.net>
	<4B29DC2B.8090405@embedded-sol.com>
	<0949C49693EF1A47A54B0F0113CDB4A60767E8@zin33exm23.fsl.freescale.net>
	<4B29F23A.9070001@embedded-sol.com>
	<0949C49693EF1A47A54B0F0113CDB4A60767F0@zin33exm23.fsl.freescale.net>
To: Mahajan Vivek-B08308 <B08308@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 17, 2009, at 2:59 AM, Mahajan Vivek-B08308 wrote:

>>=20
>> Thanks a lot. If I understand you correctly, the only way I=20
>> can get ath9k driver to work on this board using legacy=20
>> interrupts is to wait for a hardware fix. Right ?
>=20
> Correct

I'm confused.  What's the issue with IRQ0 on the P2020RDB?  Is it used =
for another purpose?

- k=
