Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5F5E5DDEEA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Oct 2007 04:10:27 +1000 (EST)
Message-ID: <47222D86.1000502@freescale.com>
Date: Fri, 26 Oct 2007 13:10:14 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Porting to /arch/powerpc
References: <020001c81756$0fc78760$5267a8c0@Jocke>
In-Reply-To: <020001c81756$0fc78760$5267a8c0@Jocke>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
>> The fs_enet driver doesn't currently support phy-less 
>> directly, but you 
>> may be able to do something with the fixed phy driver.
> 
> How is PHY less support supposed to be impl.? I would like
> to do the same for ucc_geth. I once sent a patch that made
> the PHY optional, but it never made into the driver.

Basically, the driver needs to assume the link is up if there's no 
phy-handle in the device tree, rather than error out.

-Scott
