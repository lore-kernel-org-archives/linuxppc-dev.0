Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A577DDEF9
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 02:11:06 +1000 (EST)
Message-Id: <F97FCE35-4929-4338-A4D6-53E46718F782@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Morrison, Tom" <tmorrison@empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D9010D361E25@EMPBEDEX.empirix.com>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: uboot version for 8572CDS
Date: Tue, 3 Jun 2008 11:10:49 -0500
References: <BD261180E6D35F4D9D32F3E44FD3D9010D361E25@EMPBEDEX.empirix.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Wolfgang Denk <wd@denx.de>,
	U-Boot Users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 3, 2008, at 9:41 AM, Morrison, Tom wrote:

> I am wondering if there is a development branch that contains
> support for the Freescale 8572CDS=85Looking in the latest uboot
> version (1.3.3) there is support for sbc8641 & sbc8548 =96 but
> no specific support for a sbc8572?

Such questions are best asked on the u-boot list.

I'm not aware of a 8572 CDS, we do have a 8572 DS.  And no, there =20
isn't a public tree w/support for this board.  The only code is either =20=

the FSL BSP or internal to FSL at this point.

- k=
