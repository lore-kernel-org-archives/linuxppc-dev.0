Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6Pgn4zKmzDqRG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 19:32:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>, benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, jk@ozlabs.org
Subject: Re: [PATCH] powerpc: opal-msglog: Report size of memcons log
In-Reply-To: <20170113035349.15923-1-joel@jms.id.au>
References: <20170113035349.15923-1-joel@jms.id.au>
Date: Mon, 23 Jan 2017 19:32:20 +1100
Message-ID: <87bmuyb2i3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joel Stanley <joel@jms.id.au> writes:

> The OPAL memory console is reported to be size zero, as we do not
> initialise the struct attr with any size information due to the size
> being variable. This leads users to think that the console is empty.

Hmm OK. That is a general property of /proc and /sys files that are
dynamically generated, so users probably need to get used to it :)

> Instead report the maximum size.

But OK. That sounds sane enough. My only worry is that it might confuse
some tools, ie. the file claims to be x bytes but is actually smaller.
But I guess that can actually happen anyway with any file.

So I'll merge this and stop blabbing :)

cheers
