Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E152DDEE3
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 04:45:59 +1000 (EST)
In-Reply-To: <200708020440.l724edCT290676@shell01.TheWorld.com>
References: <200708020440.l724edCT290676@shell01.TheWorld.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a650790070fdbccce792ea78776cf8a5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Pegasos keyboard detection
Date: Mon, 6 Aug 2007 20:45:52 +0200
To: Alan Curry <pacman@TheWorld.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> You don't need to patch Linux at all. In fact for silly things like 
>> this
>> I would recommend against it :)
>
> If the workaround doesn't go into the kernel, everybody with affected
> hardware has to individually find out about the bug (probably by 
> experiencing
> an annoying keyboardless boot) and fix it himself.

That's one of the reasons why this should go into a bootwrapper.


Segher
