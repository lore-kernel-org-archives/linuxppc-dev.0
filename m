Return-Path: <SRS0+d7bf1380eccd0ad21a2b+1304+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9C74DDE01
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 18:43:18 +1100 (EST)
Subject: Re: [PATCH] Complain about missing system calls.
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20070319164243.026fdbfd.akpm@linux-foundation.org>
References: <1173394873.3461.510.camel@pmac.infradead.org>
	<20070319164243.026fdbfd.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Tue, 20 Mar 2007 07:43:08 +0000
Message-Id: <1174376588.3392.168.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sam@ravnborg.org, linux-kernel@vger.kernel.org,
	rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-03-19 at 16:42 -0700, Andrew Morton wrote:
> hm, did you try running this on x86_64?

I don't have any. I only tested it on PowerPC and i386. Others then
provided more exclusions for SPARC and maybe ARM, although I'm not sure
you have the latter yet. It's not hard to add extra exclusions.

-- 
dwmw2
