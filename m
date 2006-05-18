Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3EA4567B14
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 09:55:45 +1000 (EST)
In-Reply-To: <20060518231306.GG8220@pb15.lixom.net>
References: <1147933251.463191.267166640873.qpush@pokey>
	<20060518171159.GD8220@pb15.lixom.net>
	<06890505-B9A0-42B9-A713-A035FBCBDD1B@kernel.crashing.org>
	<20060518231306.GG8220@pb15.lixom.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <67ED9F27-BB18-4D1B-8DE9-18FD744D0E59@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: Add of_parse_dma_window()
Date: Fri, 19 May 2006 01:55:38 +0200
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The code seems to be resilient against that.  Haven't tested though.
>
> Well, yes. I should have said: if it lacks the ibm,#dma- and the
> normal addr-cells properties aren't the same as we assumed before.

Missing #addr-cells means it's 2; does our code handle that correctly?
Sorry, too tired to check it myself :-)


Segher
