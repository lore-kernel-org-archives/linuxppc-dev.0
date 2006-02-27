Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9423A679FF
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2006 04:31:29 +1100 (EST)
Date: Mon, 27 Feb 2006 18:31:24 +0100
From: Olaf Hering <olh@suse.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: fix NULL pointer in handle_eeh_events
Message-ID: <20060227173124.GA18198@suse.de>
References: <20060227145259.GA15955@suse.de>
	<20060227172703.GL26339@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060227172703.GL26339@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Mon, Feb 27, Linas Vepstas wrote:

> > but ethtool -t still doesnt work right.
> 
> I'll look at this.

Reverting e100.c back to 2.6.15 status fixes it, but maybe it just does
not cover the error paths in EEH.
