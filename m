Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DDFA8DDEF1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Oct 2008 01:17:04 +1000 (EST)
Message-ID: <48E393E6.7000505@freescale.com>
Date: Wed, 01 Oct 2008 10:14:46 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Remi Lefevre <rlefevre@gmail.com>
Subject: Re: FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup (100005/1)
References: <4e0b9cb00809300944r2c2359dbx6df882705106c4d1@mail.gmail.com>	
	<48E262FF.9020108@freescale.com>
	<4e0b9cb00810010636h10c0d1fw3385ecf1f0a27be5@mail.gmail.com>
In-Reply-To: <4e0b9cb00810010636h10c0d1fw3385ecf1f0a27be5@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Remi Lefevre wrote:
> Errors encountered are "Underrun" errors (from bd).

Try elevating the arbiter priority for the FCC.

> CPM clock-frequency is not defined in the DTS, neither filled by U-Boot,
> but it doesn't seem to be needed, does it ?

Not for ethernet.

> I'm a little confused, and find strange that the first UDP request completes
> correctly, as well as latter ARP ones.

If it's bus contention (as underrun implies), then it may happen only 
under load.

-Scott
