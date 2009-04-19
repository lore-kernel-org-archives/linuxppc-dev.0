Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78C05DE09E
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 02:40:42 +1000 (EST)
Message-Id: <2B3EB2F4-7F33-4243-B39D-F9331D3E08D6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: derekzheng <zhengxiang9@163.com>
In-Reply-To: <003001c9c0d0$c6919510$53b4bf30$@com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: who know's what is "TestFloat cases" and how to test this feature
	on the Freescale MPC8536DS board
Date: Sun, 19 Apr 2009 11:40:29 -0500
References: <764365e7af2e476e43cd674738e51f13b306979b.1239874968.git.monstr@monstr.eu>	<74c0088dfda1816c21914c0a8da0c42908526c5e.1239874968.git.monstr@monstr.eu>	<20090417170707.B6C95C4004F@mail150-wa4.bigfish.com>
	<fa686aa40904172249m5e261492w48c8d9d8446600e0@mail.gmail.com>
	<003001c9c0d0$c6919510$53b4bf30$@com>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	linux-kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 19, 2009, at 4:25 AM, derekzheng wrote:

> Hi all guys:
>
> The Freescale MPC8536DS board Integrated TestFloat cases, and I do  
> not know how to test this feature on this board.
> Please tell me how to test it if you known

1. why are you CC' the microblaze list on this question?
2. I assume you are talking about the FSL BSP for MPC8536DS
3. testfloat is a set of tests.  Its not clear what your question is.   
You build testfloat and run it and it reports pass/fails.

- k
