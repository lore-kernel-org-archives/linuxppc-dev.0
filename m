Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B5694DDE02
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 17:00:29 +1000 (EST)
Message-Id: <3B2D1E3F-8D93-466C-87D0-17227FEAF1F9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: =?GB2312?B?0PEgwt4=?= <luoxu_gun@yahoo.com.cn>
In-Reply-To: <910783.28956.qm@web15908.mail.cnb.yahoo.com>
Content-Type: text/plain; charset=GB2312; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: a question about serial driver on MPC8313
Date: Thu, 17 Apr 2008 02:00:23 -0500
References: <910783.28956.qm@web15908.mail.cnb.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 16, 2008, at 8:11 PM, =D0=F1 =C2=DE wrote:
> hello all:
>     In my system, the CPU is MPC8313. When i debug it, i can't find =20=

> the serial driver for the MPC8313 soc, i can only find the file =20
> 8250.c which is in the /drivers/serial directory. I am not sure the =20=

> source code is the serial driver for the MPC8313. Could any one can =20=

> help me to solve this problem or some one can give me some advises.


the 8313 uses the 8250.c file as its a 16550 style uart.

- k=
