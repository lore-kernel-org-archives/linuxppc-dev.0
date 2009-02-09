Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32BD1DDDA8
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 02:32:30 +1100 (EST)
Message-Id: <ED186496-3882-4E87-9BEC-B56FE09C5827@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <2a27d3730902082347n7f0eb48dq8c4ecccda290f9c8@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 2/2] powerpc/83xx: Fix TSEC0 workability on MPC8313E-RDB
	boards
Date: Mon, 9 Feb 2009 09:32:18 -0600
References: <20090205201040.GB3425@oksana.dev.rtsoft.ru>
	<2a27d3730902082347n7f0eb48dq8c4ecccda290f9c8@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 9, 2009, at 1:47 AM, Li Yang wrote:

>
> It's a complex case for RDB boards.  The revision A and revision B
> boards DO always connect TSEC0 to Vitesse switch.  While the latest
> revision C board has one setting to connect TSEC0 to a Marvell PHY and
> MDIO bus.  In BSP we have several DTS's for each setting of the board,
> shouldn't we do the same for upstream?

Is this something we can detect and deal with in u-boot?  If not than  
having multiple .dts for the revisions seems like the only solution.

- k
