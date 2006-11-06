Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AEBFA67C81
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 17:12:00 +1100 (EST)
Date: Mon, 6 Nov 2006 07:11:48 +0100
From: Olaf Hering <olh@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: ppc32 PIO recovery mecanism
Message-ID: <20061106061148.GA4361@suse.de>
References: <1162773695.28571.260.camel@localhost.localdomain>
	<1162775915.3415.2.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1162775915.3415.2.camel@shinybook.infradead.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 06, David Woodhouse wrote:

> Yes, I think it's still useful because there are some drivers which
> aren't update to use check_legacy_ioport() (or whatever other system)
> yet.

What remaining drivers do you have in mind here?
