Return-Path: <segher@kernel.crashing.org>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2B12367A7A
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Feb 2005 00:14:12 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.12.10/8.12.10) with ESMTP id j1EDE6n1148168
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Feb 2005 13:14:06 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j1EDE62f177522
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Feb 2005 14:14:06 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id
	j1EDE5w5013814
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Feb 2005 14:14:06 +0100
In-Reply-To: <20050208075421.GB21154@schottelius.org>
References: <20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
	<20050127163606.GN14866@Redstar.dorchain.net>
	<20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
	<1106746946.6250.56.camel@gaston>
	<20050208075421.GB21154@schottelius.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Message-Id: <8f293b6dbedd2ae1a825608a48a0604b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Mon, 14 Feb 2005 14:14:40 +0100
To: Nico Schottelius <nico-linux-ppc@schottelius.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Heartbeat LED for iBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Btw, howto control it via /dev/adb? Can you point me to a document
> which explains that?

Write a byte 0x06 followed by the PMU packet (all in one write());
read back the PMU reply (all in one read()).


Segher
