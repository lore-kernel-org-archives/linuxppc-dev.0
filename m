Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8B3AC2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 06:04:43 +1100 (EST)
Subject: Re: [PATCH] Make PCIe hotplug work with Freescale PCIe controllers
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1510128.fXMLXu3tfm@pcimr>
Date: Wed, 13 Mar 2013 14:04:35 -0500
Message-Id: <114D22CC-22DE-43B6-BFD8-774EF2D3E912@kernel.crashing.org>
References: <3989200.gO920IVs04@pcimr>
 <92335390-A05A-4E1D-9D07-A69896768A57@kernel.crashing.org>
 <B392DAB5-F9A7-4B1A-8CAE-015CA5AC2C33@kernel.crashing.org>
 <1510128.fXMLXu3tfm@pcimr>
To: Rojhalat Ibrahim <imr@rtschenk.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 13, 2013, at 5:06 AM, Rojhalat Ibrahim wrote:

> On Tuesday 12 March 2013 15:48:01 Kumar Gala wrote:
>>> I'd rather we just export indirect_read_config() & =
indirect_write_config()
>>> from indirect_pci.c and call the functions directly.  Adding a =
global and
>>> call them via a function pointer seems wrong to me.
>>>=20
>>> - k
>>=20
>> Also, can you base this patch on my powerpc.git next branch as =
fsl_pci.{c,h}
>> have some changes in them.
>>=20
>> - k
>>=20
>=20
> Hi Kumar,
>=20
> here's the patch with direct calls to indirect_{r,w}_config based on =
your powerpc.git next branch.
>=20
> This does not work for PCIe IP rev 3.0 as I'm not sure how to handle =
"struct resource" aside from making it global or changing "struct =
pci_controller".
>=20
>   Rojhalat

I'll send a reworked version that hopefully deals with that issue that =
you can test and make sure things work ok.  As well as some other minor =
style code cleanups.

- k=
