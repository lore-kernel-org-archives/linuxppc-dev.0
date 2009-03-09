Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E225DE067
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 02:32:40 +1100 (EST)
Message-Id: <09415FD9-9E3B-4A2B-94C5-32FBF301CA9C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1236056134.20465.18.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: next branch status
Date: Mon, 9 Mar 2009 10:32:33 -0500
References: <1236056134.20465.18.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 2, 2009, at 10:55 PM, Benjamin Herrenschmidt wrote:

> Note: Kumar and Grant, pls be a bit more careful with files outside of
> arch/powerpc ... like the 5200 fec driver change, even if it's really
> powerpc only stuff and quite clearly so, it's in drivers/net, it
> wouldn't have hurt to seek davem ack for it... No big deal, it's  
> only 2
> or 3 files that I might need to give Linus an explanation about  
> tho :-)

Which files are you taking about?  The i2c driver changes got ack'd by  
Ben Dooks.

- k
