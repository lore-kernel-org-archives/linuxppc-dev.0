Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A1D69474C2
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 04:12:01 +1100 (EST)
Message-Id: <6D7DC36C-52D0-4E92-8312-B3780A7BDF73@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081205165504.GA30966@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/83xx: Fix few build errors with
	CONFIG_QUICC_ENGINE=n
Date: Fri, 5 Dec 2008 11:09:53 -0600
References: <20081205165504.GA30966@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 5, 2008, at 10:55 AM, Anton Vorontsov wrote:

> This patch implements traditional way of !QE case handling.
> Alternative version is coming (w/o ifdefs in the board files).
>
> p.s. I don't know if it is 2.6.28 material...
>
> arch/powerpc/platforms/83xx/mpc832x_rdb.c |    3 ++-
> arch/powerpc/platforms/83xx/mpc836x_rdk.c |    6 ++++--
> 2 files changed, 6 insertions(+), 3 deletions(-)

this doesn't seem critical right now so I'd say we wait for .29

- k
