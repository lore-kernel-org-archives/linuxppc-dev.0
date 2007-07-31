Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D63B3DDE00
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 07:47:49 +1000 (EST)
In-Reply-To: <02bd01c7cfbc$cf213610$02ac10ac@Jocke>
References: <02bd01c7cfbc$cf213610$02ac10ac@Jocke>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b7d58885b779a5faab36625a9eb2a40c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi,
	registermmc_spi stub
Date: Tue, 31 Jul 2007 23:47:41 +0200
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Unless the DTS guys thinks otherwise, just rename to "cpu_qe".
> "qe" would then be reserved for true QE mode.

If I understand it correctly, this is a property of how the
driver works, not how the hardware works / is connected; so
there should be _no_ such property in the device tree.

If I understand that wrong :-), just keep mode = "cpu", but
add an extra (empty) property representing that you need some
quirky mode special thing.

Either way, don't use underscores.


Segher
