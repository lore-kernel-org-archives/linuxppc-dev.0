Return-Path: <pkiryukhin@ru.mvista.com>
Received: from smtp04.mtu.ru (smtp04.mtu.ru [62.5.255.51])
	by ozlabs.org (Postfix) with ESMTP id 6492EDDEF1
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 20:08:31 +1100 (EST)
Message-ID: <47B40573.1080203@ru.mvista.com>
Date: Thu, 14 Feb 2008 12:10:11 +0300
From: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Enable correct operation of serial ports with
	nonzero regshift.
References: <47B35ED8.7020404@ru.mvista.com>
	<B8D9D613-441B-4A20-AE2D-D808D4B82F16@kernel.crashing.org>
In-Reply-To: <B8D9D613-441B-4A20-AE2D-D808D4B82F16@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Feb 13, 2008, at 3:19 PM, Pavel Kiryukhin wrote:
> 
>> Add regshift reading to serial drivers.
>> This enables correct operation of serial ports with nonzero regshift.
> 
> what device needs this?
> 
> - k

Xilinx opb 16550 uart

--
Pavel
