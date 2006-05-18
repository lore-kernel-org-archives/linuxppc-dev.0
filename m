Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA1F167B45
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 00:08:36 +1000 (EST)
In-Reply-To: <9FCDBA58F226D911B202000BDBAD46730626D618@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD46730626D618@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B00F7442-EC05-4DD0-8D2D-9B99F9555278@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/2.6.17-rc4 0/10] powerpc: add mpc7448hpc2 (Taiga) board
	support
Date: Thu, 18 May 2006 09:08:50 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 17, 2006, at 5:13 AM, Zang Roy-r61911 wrote:

> Hi, Paul
>
> 	This series of patch adds mpc7448hpc2 (taiga) board support in  
> arch/powerpc.
> 	Tsi108 chip of Tundra Semiconductor is also supported.
>
> Roy Zang

Can you post your .dts for us to take a look at.  I know Mark Greer  
is looking at support for the 105/6/7 family of bridges and the 10x  
family should have consistent flat device trees.

- kumar
