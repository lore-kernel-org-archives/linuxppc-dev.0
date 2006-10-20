Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF6BC67B55
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 23:59:27 +1000 (EST)
In-Reply-To: <20061020100010.GA5867@aepfle.de>
References: <1161300942.10524.64.camel@localhost.localdomain>
	<20061020054434.GC3277@aepfle.de>
	<1161323797.10524.150.camel@localhost.localdomain>
	<20061020062431.GB14390@powerlinux.fr>
	<20061020064456.GA3946@aepfle.de>
	<20061020065849.GA17286@powerlinux.fr>
	<20061020072037.GA4355@aepfle.de>
	<20061020073745.GC17286@powerlinux.fr>
	<D22CDFD1-C5A7-422E-9052-FFB5480AE06F@kernel.crashing.org>
	<20061020085207.GA21103@powerlinux.fr>
	<20061020100010.GA5867@aepfle.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ECBB6E7A-631F-4D57-B11A-8A137F0F1B78@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
Date: Fri, 20 Oct 2006 15:59:13 +0200
To: Olaf Hering <olaf@aepfle.de>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Sven Luther <sl@bplan-gmbh.de>,
	tilmann@bitterberg.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Yeah, that makes sense. Will the device-tree move to /sys some  
>> day ? What
>
> Moving /proc/device-tree would be an insane change.

It should really be a separate filesystem, not part of procfs;
and then people can mount it wherever they want (in theory).


Segher
