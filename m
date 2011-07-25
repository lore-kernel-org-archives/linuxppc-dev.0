Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
	[IPv6:2001:4978:20e::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5641BB6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 25 Jul 2011 22:42:00 +1000 (EST)
Subject: Re: [PATCH 0/5] ppc64 scheduler fixes
From: Peter Zijlstra <peterz@infradead.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20110725023311.175792493@samba.org>
References: <20110725023311.175792493@samba.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 25 Jul 2011 14:41:42 +0200
Message-ID: <1311597702.24752.1.camel@twins>
Mime-Version: 1.0
Cc: mingo@elte.hu, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-07-25 at 12:33 +1000, Anton Blanchard wrote:
> Here are a set of ppc64 scheduler fixes that help with some
> multi node performance issues.

They look fine to me. I'll probably ping you when I'll rip out all that
SD_NODES_PER_DOMAIN crap for good, but until then I'm fine with you
fiddling it for ppc64.

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
