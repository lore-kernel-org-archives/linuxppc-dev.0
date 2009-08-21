Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0EE9FB7BD6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 16:55:52 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 62FFDDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 16:55:51 +1000 (EST)
Message-Id: <1059A1F2-B4AA-48DC-82D6-B26D39414FA4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: hs@denx.de
In-Reply-To: <4A8E4128.6040905@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: 832x: MATH_EMUL
Date: Fri, 21 Aug 2009 01:55:40 -0500
References: <4A8E4128.6040905@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 21, 2009, at 1:39 AM, Heiko Schocher wrote:

> Hello,
>
> I actually porting a mpc8321 based port, and because there is no FPU
> on this CPU, I activated MATH_EMUL, as all other mpc832x ports did.
>
> Is there something like a counter, which counts how many times this
> Exception occurs?

Geert published some patches that did something like this but there  
isn't upstream as far as I know at this point.

- k
