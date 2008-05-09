Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3E8BDDE9E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 20:51:49 +1000 (EST)
In-Reply-To: <CC27DED0F8F39E48A7E75FD768688B7A8C16F0@zch01exm27.fsl.freescale.net>
References: <1210323810-24833-1-git-send-email-Jason.jin@freescale.com>
	<c6e4b0f3534e38db766d76fd6450f163@kernel.crashing.org>
	<CC27DED0F8F39E48A7E75FD768688B7A8C16ED@zch01exm27.fsl.freescale.net>
	<a7387ce0860d7d5bcd990f1364310221@kernel.crashing.org>
	<CC27DED0F8F39E48A7E75FD768688B7A8C16F0@zch01exm27.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <946e0a5ffab53ed52ab1afa16d0f622c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 V2] booting-without-of for Freescale MSI
Date: Fri, 9 May 2008 12:51:31 +0200
To: "Jin Zhengxiong" <Jason.Jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Sure, I didn't say to drop the property, just make it
>> optional, since most trees will want the same value anyway.
>
> So, The code should change to work with this change, If there's the
> property, use it. If no, make it all available, Am I right?

Yeah, exactly.


Segher
