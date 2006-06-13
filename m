Return-Path: <SRS0+4b0c712caa3c71df7734+1024+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 140ED67B35
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 22:43:58 +1000 (EST)
Subject: Re: 32 bit userland on G5
From: David Woodhouse <dwmw2@infradead.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1150194348.9208.33.camel@johannes>
References: <1150194348.9208.33.camel@johannes>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 13:45:08 +0100
Message-Id: <1150202709.12423.21.camel@hades.cambridge.redhat.com>
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

On Tue, 2006-06-13 at 12:25 +0200, Johannes Berg wrote:
> Since apparently the G5 honours no-execute permissions, shouldn't the 64
> bit kernel set the READ_IMPLIES_EXEC personality flag for 32-bit
> userland?

Why? Just because older hardware wasn't capable of enforcing the
permissions, that doesn't mean that we shouldn't enforce them now.

-- 
dwmw2
