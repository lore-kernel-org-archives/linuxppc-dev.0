Return-Path: <SRS0+4b0c712caa3c71df7734+1024+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4735267B2A
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 02:15:44 +1000 (EST)
Subject: Re: 32 bit userland on G5
From: David Woodhouse <dwmw2@infradead.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1150214746.6305.3.camel@johannes>
References: <1150194348.9208.33.camel@johannes>
	<1150202709.12423.21.camel@hades.cambridge.redhat.com>
	<1150214746.6305.3.camel@johannes>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 17:15:39 +0100
Message-Id: <1150215340.2844.33.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-06-13 at 18:05 +0200, Johannes Berg wrote:
> Yeah, I was just thinking that there are programs relying on that and if
> they run in the 32-bit compat mode they might rightfully do so... Dunno. 

Nah. It isn't a valid assumption; just as it isn't valid to assume that
your stack will _always_ be at about 0xbfffffff. 

-- 
dwmw2
