Return-Path: <SRS0+fe8b001394e641f94d96+1170+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B524567C6F
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 17:23:54 +1100 (EST)
Subject: Re: ppc32 PIO recovery mecanism
From: David Woodhouse <dwmw2@infradead.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20061106061148.GA4361@suse.de>
References: <1162773695.28571.260.camel@localhost.localdomain>
	<1162775915.3415.2.camel@shinybook.infradead.org>
	<20061106061148.GA4361@suse.de>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 14:24:02 +0800
Message-Id: <1162794242.3415.28.camel@shinybook.infradead.org>
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

On Mon, 2006-11-06 at 07:11 +0100, Olaf Hering wrote:
> On Mon, Nov 06, David Woodhouse wrote:
> 
> > Yes, I think it's still useful because there are some drivers which
> > aren't update to use check_legacy_ioport() (or whatever other system)
> > yet.
> 
> What remaining drivers do you have in mind here? 

Did ISAPnP get fixed?

-- 
dwmw2
