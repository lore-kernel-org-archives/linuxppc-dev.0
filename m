Return-Path: <segher@kernel.crashing.org>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2D16E67A70
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Feb 2005 00:00:00 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.12.10/8.12.10) with ESMTP id j1ICxtn1023462
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Feb 2005 12:59:55 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j1ICxtDS155562
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Feb 2005 13:59:55 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id
	j1ICxtT1028663
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Feb 2005 13:59:55 +0100
In-Reply-To: <20050218122009.GK5801@schottelius.org>
References: <20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
	<20050127163606.GN14866@Redstar.dorchain.net>
	<20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
	<1106746946.6250.56.camel@gaston>
	<20050208075421.GB21154@schottelius.org>
	<8f293b6dbedd2ae1a825608a48a0604b@kernel.crashing.org>
	<20050218111304.GH5801@schottelius.org>
	<f585c9c6e4bdfbba6dcaafc96b7c0607@kernel.crashing.org>
	<20050218122009.GK5801@schottelius.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Message-Id: <629f63c4608b762de8bf6f962b6180ef@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Fri, 18 Feb 2005 14:00:32 +0100
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

> Well, it's the last part of RTFM, so I was asking
> for the "fine manual", the documentation to ADB/PMU. So I can
> lookup the commands I need for setting the led on/off.

There is no manual.  You can look at some Darwin source code,
I guess, or there is some code in Linux to do this as well, IIRC.


Segher
