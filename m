Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 977E82BF06
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2004 17:49:41 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20041020094651.5ceff814@pirandello>
References: <20041018232004.0a9e0d5e@jack.colino.net>
	<1098143379.18687.44.camel@gaston> <20041019083432.01b947d3@pirandello>
	<1098168058.15029.45.camel@gaston> <20041020094651.5ceff814@pirandello>
Content-Type: text/plain
Message-Id: <1098258558.3223.10.camel@gaston>
Mime-Version: 1.0
Date: Wed, 20 Oct 2004 17:49:19 +1000
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: PMU questions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2004-10-20 at 17:46, Colin Leroy wrote:

> I can't find a logic in this stuff... Do you think there's a special
> reason why Apple uses such a complicated method instead of 
> a) charging until voltage stays equals for a few minutes
> b) draining until voltage goes under 13.5 volts (or 13, or whatever)
> 
> In my uninformed opinion that would work better, wouldn't it?

I don't know...

Ben.
