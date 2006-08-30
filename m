Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D15167B54
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 23:30:06 +1000 (EST)
In-Reply-To: <995B09A8299C2C44B59866F6391D263511BA03@zch01exm21.fsl.freescale.net>
References: <995B09A8299C2C44B59866F6391D263511BA03@zch01exm21.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E8F8F71E-CEB8-4CEE-ACB7-AB602AB410BF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] corrected PCI interrupt sense values to level low
	inmpc8349emds.dts
Date: Wed, 30 Aug 2006 08:29:59 -0500
To: Liu Dave-r63238 <DaveLiu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Where these IDSEL 0x15~0x18 come from on 8349EMDS board?
> Please expain it.

This is from the docs on the PMC-PCI expansion boards that state what  
IDSELs are used and how they are wired up.

- k
