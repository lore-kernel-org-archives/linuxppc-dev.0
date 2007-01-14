Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16284DDECB
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 11:38:42 +1100 (EST)
In-Reply-To: <1168734544.5011.78.camel@localhost.localdomain>
References: <20070113154029.GA32292@eecg.toronto.edu>
	<1168734544.5011.78.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dd188efa1bcb288b11f0b7c601c8778a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix performance monitor exception in 2.6.20-series
Date: Sun, 14 Jan 2007 01:39:17 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Livio Soares <livio@eecg.toronto.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Well, are you absolutely sure that nothing will break as a result of
> having a PMU interrupt happening right when it's not expected to ?
>
> You are basically turning the PMU interrupt into an NMI... I'm not sure
> how safe that is.

That just depends what code is run from the PMU exception.
It very much makes sense *conceptually* to have it behave
like an NMI I think -- but yeah the code run from the
exception had better behave ;-)


Segher
