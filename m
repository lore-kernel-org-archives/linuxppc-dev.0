Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 562B3DDE46
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 18:14:11 +1000 (EST)
In-Reply-To: <20070603232529.GA24977@mag.az.mvista.com>
References: <Pine.GSO.4.63.0705250829380.19095@hydra.cs.vu.nl>
	<18018.7868.811862.733793@cargo.ozlabs.ibm.com>
	<20070603232529.GA24977@mag.az.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <da9d2a3c5abeb9fed06acbf1f37b06aa@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: ps3 64-bit kernel: patched prpmc2800.c (fwd)
Date: Mon, 4 Jun 2007 10:14:04 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev@ozlabs.org, Maik Nijhuis <maik@cs.vu.nl>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> It is a binutils bug, and Alan Modra has a patch for it.  In the
>> meantime the best thing would be to change that to
>>
>> 	rlwinm	10,10,0,17,15
>>
>> which is equivalent.
>
> Oops, I totally missed this thread.  I'll whip up a patch for this on 
> Monday.

Unless I'm mistaken, this bug doesn't exist in any released
version of binutils, so no kernel patch should be necessary
(people using a development version of binutils should just
upgrade to the latest, which has this fixed already).


Segher
