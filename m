Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4E58DDEFD
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jul 2007 21:58:53 +1000 (EST)
In-Reply-To: <E6C54DC8-3152-4EE6-A1A1-389B41B23FC9@kernel.crashing.org>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<E6C54DC8-3152-4EE6-A1A1-389B41B23FC9@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <186c9062157e6896bd2c8ddaae6389db@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
Date: Mon, 2 Jul 2007 13:56:35 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Add of_register_i2c_devices(), which scans the children of the
>> specified
>> I2C adapter node, and registers them with the I2C code.
>>
>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>> Signed-off-by: G. Liakhovetski <g.liakhovetski@gmx.de>
>
> I'm still against this patch since it means we are stating that I2C
> devices in the device tree must us the linux driver names.  The two
> should be de-coupled.

Very much so.  More comments as reply to the original post...


Segher
