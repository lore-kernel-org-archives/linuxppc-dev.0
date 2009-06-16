Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B290AB71D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 06:28:56 +1000 (EST)
Message-ID: <4A380094.3030909@freescale.com>
Date: Tue, 16 Jun 2009 15:29:08 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: John Linn <John.Linn@xilinx.com>
Subject: Re: 2.6.30 kernel panic with any network driver
References: <20090616181334.1EBABA8056@mail2-sin.bigfish.com>
In-Reply-To: <20090616181334.1EBABA8056@mail2-sin.bigfish.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

John Linn wrote:
> console [ttyS0] enabled
> 
> brd: module loaded
> 
> loop: module loaded
> 
> Unable to handle kernel paging request for data at address 0x75686369

That address spells "uhci", FWIW.  Maybe a bad pointer cast somewhere in 
the USB platform data?

-Scott
