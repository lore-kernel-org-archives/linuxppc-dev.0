Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B4B7BDDE9E
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 06:53:17 +1000 (EST)
Subject: Re: Please revert edada399 and 9203fc9c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20090428083528.GA17622@uranus.ravnborg.org>
References: <18934.35969.872225.70725@cargo.ozlabs.ibm.com>
	<20090428083528.GA17622@uranus.ravnborg.org>
Content-Type: text/plain
Date: Wed, 29 Apr 2009 06:52:27 +1000
Message-Id: <1240951947.15263.5.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	Tim Abbott <tabbott@MIT.EDU>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-04-28 at 10:35 +0200, Sam Ravnborg wrote:

> This is partly my fault :-(
> I acked them as I did not see the issue with conditional branches.
> Could I ask you to add a comment to the lds file about this.

I'm back :-)

Not a huge deal per-se, it's just that the patches were merged in Linus
tree only a few hours after being initially submitted it seems, which
doesn't leave much chance for anybody to test, to hit -next, or anything
like that... that was a little bit too trigger happy .

Cheers,
Ben.
