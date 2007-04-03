Return-Path: <SRS0+3550a31010a0b33b2856+1318+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E4CDDDECB
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 08:59:23 +1000 (EST)
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Woodhouse <dwmw2@infradead.org>
To: Brad Boyer <flar@allandria.com>
In-Reply-To: <20070403203735.GB12332@cynthia.pants.nu>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<20070403203735.GB12332@cynthia.pants.nu>
Content-Type: text/plain
Date: Tue, 03 Apr 2007 18:58:39 -0400
Message-Id: <1175641120.10567.15.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-03 at 13:37 -0700, Brad Boyer wrote:
> Shouldn't we have defines for these? It doesn't seem good to have more
> magic numbers floating around in the code.

I wondered about that, but decided against it. They're only used in one
place, and it's obvious what they are and where they come from. It's not
as if '#define PMAC_ZILOG_MAJOR 204' and '.major = PMAC_ZILOG_MAJOR'
would actually make it any clearer. Quite the opposite, in fact, since
204 is used for other things too.

-- 
dwmw2
