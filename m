Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7268F67B55
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jun 2005 08:45:55 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Garcia =?ISO-8859-1?Q?J=E9r=E9mie?= <GARCIAJ@3il.fr>
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B32@exnet.3il.fr>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B32@exnet.3il.fr>
Content-Type: text/plain; charset=utf-8
Date: Fri, 10 Jun 2005 08:42:49 +1000
Message-Id: <1118356969.6850.179.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: RE : PPC arch and spinlocks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-06-09 at 11:28 +0200, Garcia Jérémie wrote:
> First of all,tks Jeff for this link. 
> So reading that, I understood that I need to enable the SMP support in the makemenuconfig
> in order to use spinlocks even if I'm working on UP platform.
> That's what I did but I now go through compile errors (I'm using a montavista PE 3.1):

No, spinlocks are always around, though they do nothing on UP (except if
you use the _irq variants). Also, SMP isn't supported on 4xx.

You should do what Hollis says :)

Ben.
