Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5E4F0DDEED
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Apr 2007 06:18:14 +1000 (EST)
In-Reply-To: <3C02138692C13C4BB675FE7EA24095293284D7@bluefin.Soneticom.local>
References: <3C02138692C13C4BB675FE7EA24095293284D7@bluefin.Soneticom.local>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <56EADD43-F9B3-427E-9322-AAC708EF2CCC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Linux 2.6 and uboot
Date: Fri, 13 Apr 2007 15:17:51 -0500
To: Clint Thomas <cthomas@Soneticom.com>
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


On Apr 13, 2007, at 2:55 PM, Clint Thomas wrote:

> Is there any correlation between the version of U-boot to use on a  
> board
> and the version of the Linux kernel you plan to use? Current I'm  
> running
> U-boot 1.1.2 with kernel 2.4.26 on my MPC85xx board, but i'm trying to
> migrate to the latest 2.6 kernel. I am getting a kernel hang at boot
> when it registers socket family 17, so I was wondering if it might  
> have
> to do with u-boot before exploring the debug route.

That's an odd place to hang. Which 2.6 kernel are you using?  Also  
are you using arch/ppc or arch/powerpc?

- k
