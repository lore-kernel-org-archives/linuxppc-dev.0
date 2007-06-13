Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C366DDDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 23:51:58 +1000 (EST)
In-Reply-To: <20070613122852.GA30524@aepfle.de>
References: <20070612181825.730300780@am.sony.com>>
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<20070613084023.GA28629@aepfle.de>
	<0502b4de346bce374f98c49a99be50c1@kernel.crashing.org>
	<20070613112448.GA29239@aepfle.de>
	<184b5119eca8beae9a28453096b6fe26@kernel.crashing.org>
	<20070613122852.GA30524@aepfle.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d225d2e50cd1881a9fe2c015c3602c4c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 29/30] PS3: Device tree source.
Date: Wed, 13 Jun 2007 15:51:52 +0200
To: Olaf Hering <olaf@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The device tree is not a userspace ABI.
>
> It is an userspace ABI. Simply because at some point the OS wants to 
> know
> which platform/boardtype/whatever it is running on.

What's wrong with uname -m or cat /proc/cpuinfo?


Segher
