Return-Path: <daveg@sonartech.com.au>
Received: from sonartech.com.au (newgate.sonartech.com.au [203.28.130.2])
	by ozlabs.org (Postfix) with ESMTP id 219552BD3C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2004 17:53:17 +1000 (EST)
Message-ID: <414946A0.1020306@sonartech.com.au>
Date: Thu, 16 Sep 2004 17:54:08 +1000
From: David Gardiner <daveg@sonartech.com.au>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <414916BD.9080607@sonartech.com.au>
	<20040915223624.A25752@home.com>
In-Reply-To: <20040915223624.A25752@home.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Linux-2.6.9-rc2 kernel build for mvme5100
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>You need this patch:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0409.1/1192.html
>
>-Matt
>  
>
Thanks that compiles, but it doesn't boot, I got:

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&1305095, Bytes Loaded =&1305095
Bytes/Second   =&1305095, Elapsed Time =1 Second(s)

Residual-Data Located at: $1FEA137C
loaded at:     00005400 00144530
relocated to:  00800000 0093F130
zimage at:     00805905 0093CA9F
avail ram:     00400000 00800000

Linux/PPC load: ip=on panic=3 bigphysarea=8192 root=/dev/sda5
Uncompressing Linux...done.
Now booting the kernel
