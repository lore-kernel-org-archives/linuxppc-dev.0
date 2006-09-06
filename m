Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5537267B71
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 01:27:05 +1000 (EST)
In-Reply-To: <20060906101034.404014f7@localhost.localdomain>
References: <20060904175742.5472a6fa@localhost.localdomain>
	<20060905122956.2cebd36d@localhost.localdomain>
	<0C880511-D99D-4160-9EB1-A66B22B2D82F@kernel.crashing.org>
	<20060906101034.404014f7@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E2C62E02-AB23-451F-8A82-718A13B675BE@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [4/5] powerpc: PA Semi PWRficient platform support
Date: Wed, 6 Sep 2006 17:26:02 +0200
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Very nice, I'll convert maple to do the same (unless someone beats
>> me to it, heh).
>
> Maple isn't that different there. It just has to deal with multiple  
> ISUs,
> while we currently only have one.

Maple has only one as well, that's the point :-)
It gets the ISU address from that awful platform-open-pic
property currently, hardcoding it like you did for PA6T is
just fine though.  It simplifies the code quite a bit and
doesn't depend on this undocumented (and badly defined no
matter what) device tree property.


Segher
