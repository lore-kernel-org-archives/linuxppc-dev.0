Return-Path: <sebastian@breakpoint.cc>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 62796B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 17:25:48 +1000 (EST)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3556DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 17:25:47 +1000 (EST)
Date: Thu, 6 Aug 2009 09:25:36 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Kenneth Johansson <kenneth@southpole.se>
Subject: Re: kexec on e300 core / mpc5121
Message-ID: <20090806072536.GA9290@Chamillionaire.breakpoint.cc>
References: <20090804230605.GA28753@Chamillionaire.breakpoint.cc>
	<1249512585.13069.9.camel@localhost>
	<20090805234737.GA26183@b07421-ec1.am.freescale.net>
	<1249518050.13069.21.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1249518050.13069.21.camel@localhost>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Kenneth Johansson | 2009-08-06 02:20:50 [+0200]:

>> > Is it not possible to disable the mmu on all cpu's that have one ?? 
>> 
>> No, on e500 for example it is always on.  You can use large pages with
>> identity maps to make it seem like it's off, though.
>
>why do something like that ? 
on e500 you simply can't disable the mmu. It is always on even if you
come out of reset.

Sebastian
