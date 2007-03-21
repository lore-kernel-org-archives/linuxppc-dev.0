Return-Path: <SRS0+4da83bd29f7d47e599c0+1305+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A4EFDDDEAB
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 22:25:37 +1100 (EST)
Subject: Re: [PATCH] Complain about missing system calls.
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20070319164243.026fdbfd.akpm@linux-foundation.org>
References: <1173394873.3461.510.camel@pmac.infradead.org>
	<20070319164243.026fdbfd.akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Mar 2007 11:25:30 +0000
Message-Id: <1174476330.20505.54.camel@pmac.infradead.org>
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

git://git.infradead.org/~dwmw2/syscalls-2.6.git

Should make it quieter on ARM and x86_64, and includes Stéphane's patch
to make it work with dash.

-- 
dwmw2
