Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 431ADDDF08
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 02:49:50 +1100 (EST)
Subject: Re: MPC8321, ethernet and i2c problems after upgrade from 2.6.25
	to 2.6.27
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
In-Reply-To: <1223899315.32141.42.camel@gentoo-jocke.transmode.se>
References: <1223899315.32141.42.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain
Date: Mon, 13 Oct 2008 17:49:47 +0200
Message-Id: <1223912987.32141.56.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-13 at 14:01 +0200, Joakim Tjernlund wrote:
> So I upgraded my tree for our custom mpc8321 boards.
> I2c and ethernet stopped working.
> 
> Ethernet: I am using the ucc_geth driver and now
> it seems like it won't TX any pkgs.
> ethtool -S eth0  shows that the RX countes are increasing but
> the TX ones stays a zero. 

The ethernet problem turned out to be .bd_mem_part = MEM_PART_MURAM
not working anymore.
The default .bd_mem_part = MEM_PART_SYSTEM works. No idea as
to what caused this though.

    Jocke
