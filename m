Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1DAFDDE39
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 06:56:11 +1000 (EST)
Subject: Re: Sequoia kernel crash workaround.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <46F79305.9050300@ru.mvista.com>
References: <46F16CC9.3010003@ru.mvista.com> <200709192119.48259.sr@denx.de>
	<20070919193024.GA28163@lixom.net>
	<20070919150818.3fecc1bc@weaponx.rchland.ibm.com>
	<46F2A640.1000802@ru.mvista.com> <20070920172506.GA16354@lixom.net>
	<20070920122919.32dd8061@weaponx.rchland.ibm.com>
	<1190535664.3723.16.camel@localhost.localdomain>
	<46F79305.9050300@ru.mvista.com>
Content-Type: text/plain
Date: Tue, 25 Sep 2007 06:55:50 +1000
Message-Id: <1190667350.6886.59.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>,
	Josh Boyer <jwboyer@gmail.com>, Stefan Roese <sr@denx.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-09-24 at 14:35 +0400, Valentine Barshak wrote:
> 
>  From what I've seen, setup_cpu is never called for BOOKE.
> Currently It's called from cputable.c for PPC64 and from head_32.S for
> 6xx.
> Thanks,

Right. We need to fix/converge some of these but it's not totally
trivial.

Ben.
