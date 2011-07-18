Return-Path: <eric.dumazet@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23930B6F6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 06:05:16 +1000 (EST)
Received: by wwj40 with SMTP id 40so2791883wwj.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jul 2011 13:05:12 -0700 (PDT)
Subject: Re: [PATCH] net: filter: BPF 'JIT' compiler for PPC64
From: Eric Dumazet <eric.dumazet@gmail.com>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20110718.124248.1462465498024218250.davem@davemloft.net>
References: <4E23E5C3.1070209@ozlabs.org>
	<1310978375.5756.7.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
	<20110718.124248.1462465498024218250.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Jul 2011 22:05:08 +0200
Message-ID: <1311019508.16961.1.camel@edumazet-laptop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le lundi 18 juillet 2011 à 12:42 -0700, David Miller a écrit :
> From: Eric Dumazet <eric.dumazet@gmail.com>
> Date: Mon, 18 Jul 2011 10:39:35 +0200
> 
> > So in PPC SEEN_XREG only is to be set of X is read, not if written.
> > 
> > So you dont have to set SEEN_XREG bit in this part :
> 
> Matt, do you want to integrate changes based upon Eric's feedback
> here or do you want me to apply your patch as-is for now?
> 

This was a really minor point, so Matt feel free to ask an immediate
inclusion ;)
