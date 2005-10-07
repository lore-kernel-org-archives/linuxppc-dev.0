Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 261B468504
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Oct 2005 10:56:18 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paolo Galtieri <pgaltieri@mvista.com>
In-Reply-To: <1128639689.4809.19.camel@playin.mvista.com>
References: <1128639689.4809.19.camel@playin.mvista.com>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 10:54:40 +1000
Message-Id: <1128646480.17365.7.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Two bugs in handling of highmem on PPC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 
> I would very much appreciate it if those of you who are more familiar
> with this part of the kernel could review and comment on my
> interpretation of what is going on and provide feedback.

While the first bit of your patch makes some sense, the second one
doesn't at all to me, you must be missing something there...

Ben
