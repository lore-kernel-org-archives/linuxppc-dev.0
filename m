Return-Path: <segher@kernel.crashing.org>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4DE6167A7A
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Feb 2005 05:10:08 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.12.10/8.12.10) with ESMTP id j1IIA4n1043100
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Feb 2005 18:10:04 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j1IIA4DS166954
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Feb 2005 19:10:04 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id
	j1IIA3sL010917
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Feb 2005 19:10:04 +0100
In-Reply-To: <20050218175822.GA30616@pants.nu>
References: <20050127163606.GN14866@Redstar.dorchain.net>
	<20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
	<1106746946.6250.56.camel@gaston>
	<20050208075421.GB21154@schottelius.org>
	<8f293b6dbedd2ae1a825608a48a0604b@kernel.crashing.org>
	<20050218111304.GH5801@schottelius.org>
	<f585c9c6e4bdfbba6dcaafc96b7c0607@kernel.crashing.org>
	<20050218122009.GK5801@schottelius.org>
	<629f63c4608b762de8bf6f962b6180ef@kernel.crashing.org>
	<20050218175822.GA30616@pants.nu>
Mime-Version: 1.0 (Apple Message framework v619.2)
Message-Id: <06fb81c4f23d0b47f8205b433fa6eb21@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Fri, 18 Feb 2005 19:10:42 +0100
To: Brad Boyer <flar@allandria.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Nico Schottelius <nico-linux-ppc@schottelius.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Heartbeat LED for iBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> There is some minimal documentation available. Some Apple docs:
>
> ADB-The Untold Story: Space Aliens Ate My Mouse
> http://developer.apple.com/technotes/hw/hw_01.html
>
> Inside Macintosh: Devices / Chapter 5 - ADB Manager
> http://developer.apple.com/documentation/mac/Devices/Devices-203.html
>
> These will tell you the basic design of ADB as well as the packet
> formats and information about keyboards and mice.
>
> Note that these document ADB in a generic sense, so nothing PMU
> specific is in them. Apple has been very reluctant to document
> the PMU and it's functions.

ADB has nothing to do with the PMU (well, the PMU emulates an ADB
device, sort of).

The Linux kernel multiplexes the /dev/adb device to also serve as
a channel to the PMU, though.  This ugliness should be fixed, some
day...


Segher
