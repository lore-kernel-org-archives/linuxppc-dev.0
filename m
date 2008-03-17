Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 05E1DDE168
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 06:42:18 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] 83xx: MPC837xRDB's VSC7385 ethernet switch
	isn't on the MDIO bus
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080317175208.GA17844@localhost.localdomain>
References: <20080317175208.GA17844@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 17 Mar 2008 20:42:15 +0100
Message-Id: <1205782935.7589.55.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-03-17 at 20:52 +0300, Anton Vorontsov wrote:
> MDIO-less PHYs should use CONFIG_FIXED_PHY driver and appropriate
> fixed-link property in the device tree.
> 
> If not, ethernet will not work:
>   e0024520:03 not found
>   eth1: Could not attach to PHY
>   IP-Config: Failed to open eth1
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Trying to add fixed-link support for ucc_geth as this is broken too. I
noticed that ifconfig eth1 up follwed by ifconfig eth1 down hangs
my board once I got the ucc_geth driver to recognize fixed-link.
Does it work for you?

 Jocke
