Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08571DDE98
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 13:20:05 +1000 (EST)
Subject: Re: [PATCH] elf loader support for auxvec base platform string
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0807170908060.2959@woody.linux-foundation.org>
References: <1216166331-14810-1-git-send-email-ntl@pobox.com>
	<1216166331-14810-2-git-send-email-ntl@pobox.com>
	<1216276539.7740.309.camel@pasglop>
	<alpine.LFD.1.10.0807170908060.2959@woody.linux-foundation.org>
Content-Type: text/plain
Date: Mon, 21 Jul 2008 13:19:48 +1000
Message-Id: <1216610388.11027.77.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Nathan Lynch <ntl@pobox.com>, linux-kernel@vger.kernel.org,
	roland@redhat.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-17 at 09:10 -0700, Linus Torvalds wrote:
> 
> On Thu, 17 Jul 2008, Benjamin Herrenschmidt wrote:
> > 
> > Should I seek somebody's ack before merging a patch like the one below ?
> > 
> > I'm a bit reluctant to merge via the powerpc.git tree some changes to
> > generic files without at least an ack from somebody else :-)
> 
> Gaah. Generally we don't, but you're right to ask. The ELF loading keeps 
> on accumulating these things, and I'm not sure we have the right process 
> for things like this. They're all individually small and insignificant, 
> and they are all individually never going away and making the ELF loader 
> messier and messier.

Yeah, annoying. Oh well, this one at least is now getting Andrew's
scrutinity...

Cheers,
Ben.
