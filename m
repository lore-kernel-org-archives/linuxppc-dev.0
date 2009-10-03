Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B305BB7BB9
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 21:20:22 +1000 (EST)
Subject: Re: Is volatile always verboten for FSL QE structures?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <20091003095537.GA15992@honey.hogyros.de>
References: <4AC60AD8.8030509@ruggedcom.com> <4AC61247.1030507@freescale.com>
	<C3FE6281-04FA-48B3-96EA-D6E68AF65D6B@kernel.crashing.org>
	<4AC63112.7080404@ruggedcom.com>
	<20091002200848.06be4c5a@xilun.lan.proformatique.com>
	<20091003095537.GA15992@honey.hogyros.de>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 03 Oct 2009 21:20:08 +1000
Message-Id: <1254568808.7122.21.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Making the target of foo volatile properly rechecks the condition on
> each iteration.
> 
> OTOH my PPC box runs fine, so I'm probably missing something obvious.

Probably because the IO accessors do -both- volatile casts and
add the barriers :-) 

Ben.
