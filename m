Return-Path: <pku.leo@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id 8D788DDD1C
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Feb 2009 18:47:49 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so1840742wfd.15
	for <linuxppc-dev@ozlabs.org>; Sun, 08 Feb 2009 23:47:47 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <20090205201040.GB3425@oksana.dev.rtsoft.ru>
References: <20090205201040.GB3425@oksana.dev.rtsoft.ru>
Date: Mon, 9 Feb 2009 15:47:47 +0800
Message-ID: <2a27d3730902082347n7f0eb48dq8c4ecccda290f9c8@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/83xx: Fix TSEC0 workability on MPC8313E-RDB
	boards
From: Li Yang <leoli@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 6, 2009 at 4:10 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> TSEC0 is connected to Vitesse 7385 5-port switch. The switch
> isn't connected to any mdio bus, the link to the switch is fixed
> to Full-duplex 1000 Mb/s (no pause).

It's a complex case for RDB boards.  The revision A and revision B
boards DO always connect TSEC0 to Vitesse switch.  While the latest
revision C board has one setting to connect TSEC0 to a Marvell PHY and
MDIO bus.  In BSP we have several DTS's for each setting of the board,
shouldn't we do the same for upstream?

- Leo
