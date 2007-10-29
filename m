Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 95771DDFE6
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 14:24:38 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix demotion of segments to 4K pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071029030648.GA14199@lixom.net>
References: <1193619918.9928.0.camel@pasglop>
	<20071029015014.GA13687@lixom.net> <1193623229.9928.2.camel@pasglop>
	<20071029030648.GA14199@lixom.net>
Content-Type: text/plain
Date: Mon, 29 Oct 2007 14:24:28 +1100
Message-Id: <1193628268.9928.16.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-10-28 at 22:06 -0500, Olof Johansson wrote:
> > And I don't care, I will continue adding them because the opposite
> is
> > fugly :-)
> 
> Yeah , I know what you mean . This looks so much more natural .

Who said it has to be consistent ? :-)

I use spaces before ? and ! mostly. In fact, it might even be the rule
in french, I'm not too sure :-)

Ben.
