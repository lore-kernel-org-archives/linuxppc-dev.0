Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C60F2DDF09
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 18:03:01 +1100 (EST)
Subject: Re: [ANN] Introducing new "test" branch in powerpc.git tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C50C2A8C-956C-49FF-98BC-7F46231AFBF3@kernel.crashing.org>
References: <1233806493.4612.65.camel@pasglop>
	<C50C2A8C-956C-49FF-98BC-7F46231AFBF3@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 05 Feb 2009 18:02:37 +1100
Message-Id: <1233817357.4612.79.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-02-04 at 23:53 -0600, Kumar Gala wrote:
> 
> Are you going to ask "test" get pulled into Stephen's -next tree?

No, I don't intend to let things stage long enough in "test" for that to
matter and I asked Stephen, he isn't hot about it. Hopefully the max
lifetime for something in "test" should be around a week.

It's really a way for me to advertise what I want to push out and still
have a last minute chance to catch big mistakes.

Cheers,
Ben.
