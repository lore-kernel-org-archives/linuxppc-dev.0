Return-Path: <kenneth@southpole.se>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 014BEB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Sep 2009 21:16:22 +1000 (EST)
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id C3910DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Sep 2009 21:16:18 +1000 (EST)
Subject: Re: Question about e300 core decrementer interrupt
From: Kenneth Johansson <kenneth@southpole.se>
To: Li Tao-B22598 <B22598@freescale.com>
In-Reply-To: <FF7429C6AD6EFB489C0A5A2021CDFEFA7C30E6@zmy16exm21.fsl.freescale.net>
References: <FF7429C6AD6EFB489C0A5A2021CDFEFA7C30E6@zmy16exm21.fsl.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Sep 2009 13:16:07 +0200
Message-Id: <1252494967.10293.6.camel@localhost>
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

On Tue, 2009-09-08 at 13:48 +0800, Li Tao-B22598 wrote:
> Dear all,
> 
> I have a problem in MPC5121 sleep mode. As you know MPC5121 use e300c4
> core. When I make the e300c4 core into sleep mode, it will return to
> full power mode when the“decrementer interrupt” occurred.
> 
> But in the e300 core reference manual said that the “decrementer
> interrupt”have no effect when e300 core in sleep mode, because the
> time
> base and decrementer are disabled while the core is in sleep mode.
> Can anybody explain about this procedure ?


Please talk to people internal to freescale. There is errata on this
that is known for a long time(more than a year now) that for some reason
is never entered into the errata document. 

I'm a bit irritated that it's not as the "solution" can mean hardware
changes an thus it's potentially expensive.
