Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F40F02BD7B
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Sep 2004 20:24:22 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
In-Reply-To: <Pine.LNX.4.58.0409191105090.31452@ppg_penguin.kenmoffat.uklinux.net>
References: <Pine.LNX.4.58.0409172249520.23520@ppg_penguin.kenmoffat.uklinux.net>
	<1095465662.3660.3.camel@gaston>
	<Pine.LNX.4.58.0409181032540.26433@ppg_penguin.kenmoffat.uklinux.net>
	<1095502166.6545.5.camel@gaston>
	<Pine.LNX.4.58.0409181233590.26883@ppg_penguin.kenmoffat.uklinux.net>
	<Pine.LNX.4.58.0409181735400.27956@ppg_penguin.kenmoffat.uklinux.net>
	<1095567908.6545.12.camel@gaston>
	<Pine.LNX.4.58.0409191105090.31452@ppg_penguin.kenmoffat.uklinux.net>
Content-Type: text/plain
Message-Id: <1095589403.23182.1.camel@gaston>
Mime-Version: 1.0
Date: Sun, 19 Sep 2004 20:23:23 +1000
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Problem with 745x errata in 2.6.8
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2004-09-19 at 20:16, Ken Moffat wrote:

>  Actually, I think it's kept in a locked cupboard in a room labelled
> "beware of the leopard", in a basement at the bottom of some broken
> stairs.  FWIW, the option biting me is CPU_FTR_NEED_COHERENT - no real
> surprises there.
> 
>  I'll have another go at trying to talk to them.  Thanks for your
> responses.

Yes, we have to set the "M" (coherent) bit on all memory pages even
when not running SMP on those CPUs to work around a CPU bug.

Ben.
 
