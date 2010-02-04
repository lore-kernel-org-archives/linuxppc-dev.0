Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BDE3FB7D4F
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Feb 2010 11:18:50 +1100 (EST)
Subject: Re: [patch 1/2] powerpc: Sky CPU: redundant or incorrect tests on
	unsigned
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: support <support@skycomputers.com>
In-Reply-To: <B134A7A4FBBE4369B89D3A549EA6BD88@your4dacd0ea75>
References: <201002022240.o12Me1iY018842@imap1.linux-foundation.org>
	<1265239287.8287.125.camel@pasglop>
	<B134A7A4FBBE4369B89D3A549EA6BD88@your4dacd0ea75>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Feb 2010 11:18:35 +1100
Message-ID: <1265242715.8287.127.camel@pasglop>
Mime-Version: 1.0
Cc: waite@skycomputers.com, roel.kluin@gmail.com, gorcunov@gmail.com,
	linuxppc-dev@ozlabs.org, galak@gate.crashing.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-02-03 at 19:10 -0500, support wrote:
> The sky cpu is a PPC7448.
> I'm actually amazed that you guys are still working on a problem for
> a 
> product that was finished a number of years ago, at the request of
> someone 
> who hasn't worked here for years.
> I sorry you, seem to have been wasting your time.
> I think, but am NOT sure,  that our HAA function sets it off.
> http://www.skycomputers.com/Systems/HAA_HMM.php
> 
> Still, we have finished the product some time ago, and as far as
> reported 
> have no problems.
> Again, I'm sorry you have wasted any time on this, we just recently
> found 
> these emails.

Well, there seem to be some code in the Linux kernel related to that CPU
that is either dead or incomplete. So if you guys have no interest in
it, we might just rip it out completely.

Cheers,
Ben.
