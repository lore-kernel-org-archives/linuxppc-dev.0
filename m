Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D555067A45
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2005 20:44:58 +1100 (EST)
Date: Fri, 21 Jan 2005 10:44:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20050121094438.GA18682@lst.de>
References: <41EC29A8.1040703@mvista.com> <1106259956.18397.10.camel@gaston>
	<41F0449C.5020603@mvista.com> <1106265672.5387.14.camel@gaston>
	<41F04849.70506@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41F04849.70506@mvista.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 20, 2005 at 05:09:45PM -0700, Mark A. Greer wrote:
> >In any case, as I wrote, the proper solution is to update genrtc to
> >define rtc_ops so that you get both a) and b), it shouldn't be hard to
> >update the archs using it.
> > 
> >
> 
> Yes but as I wrote, I don't have time right now.

You could have easily implemented it in the time you wasted arguing
here.
