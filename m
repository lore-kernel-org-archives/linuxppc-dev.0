Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3715C2BDB5
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 08:50:30 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Keith Conger <keith.conger@gmail.com>
In-Reply-To: <4517b8e0411220858256619b4@mail.gmail.com>
References: <1100847411.25521.42.camel@gaston>
	<1100852423.3855.2.camel@gaston> <1101083578.13597.5.camel@gaston>
	<6ullcuggfr.fsf@zork.zork.net>
	<4517b8e04112208383cc9b24c@mail.gmail.com>
	<4517b8e0411220858256619b4@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 23 Nov 2004 08:48:58 +1100
Message-Id: <1101160138.13612.119.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: TEST: Sleep patch #4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2004-11-22 at 11:58 -0500, Keith Conger wrote:
> Hi,
> 
> Two things I forgot to include, the sound problem happens with or
> without going to sleep. Also here is something that apears in my
> dmesg:
> Oops: kernel access of bad area, sig: 11 [#3]
> PREEMPT
>
> .../...

Alsa bugs (as well). You should probably report this to the proper
driver author/maintainer.

Ben.
