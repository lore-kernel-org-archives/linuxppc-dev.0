Return-Path: <segher@kernel.crashing.org>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A585B67A6B
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Feb 2005 23:10:31 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id j1ICAOvK093240
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Feb 2005 12:10:24 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j1ICANDS142986
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Feb 2005 13:10:23 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id
	j1ICAN0l005815
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Feb 2005 13:10:23 +0100
In-Reply-To: <20050218111304.GH5801@schottelius.org>
References: <20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
	<20050127163606.GN14866@Redstar.dorchain.net>
	<20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
	<1106746946.6250.56.camel@gaston>
	<20050208075421.GB21154@schottelius.org>
	<8f293b6dbedd2ae1a825608a48a0604b@kernel.crashing.org>
	<20050218111304.GH5801@schottelius.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Message-Id: <f585c9c6e4bdfbba6dcaafc96b7c0607@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Fri, 18 Feb 2005 13:11:00 +0100
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

>>> Btw, howto control it via /dev/adb? Can you point me to a document
>>> which explains that?
>>
>> Write a byte 0x06 followed by the PMU packet (all in one write());
>> read back the PMU reply (all in one read()).
>
> What exactly does 0x06 mean?

6 just means "send to PMU".  It is a Linux thing, nothing to do
with the PMU itself.

> Flash led? Isn't there some kind of
> "bright-led" "5V,12V,24V" settings available? I mean I want to be able
> to change the brightness.

You can't change brightness on a LED.  You can however make it blink,
say, a few hundred times per second, and change the duty-cycle.

> And what is the PMU packet? One Byte, two byte, value 0x2342?

Dunno what the exact command for this is.

> Please point me to a FM about adb.

What is a FM?  And it has nothing to do with ADB.


Segher
