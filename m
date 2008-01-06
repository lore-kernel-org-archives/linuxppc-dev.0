Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 48452DDE17
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 09:46:40 +1100 (EST)
Date: Sun, 6 Jan 2008 16:46:24 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] Handle absolute pathnames correctly in dtc_open_file.
Message-ID: <20080106224623.GA8239@ld0162-tx32.am.freescale.net>
References: <20080104211045.GB28991@ld0162-tx32.am.freescale.net>
	<20080106033716.GL4326@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080106033716.GL4326@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 06, 2008 at 02:37:16PM +1100, David Gibson wrote:
> >  out:
> > +	free((void *)file->dir);
> 
> That cast shouldn't be there.

It generates a constness warning otherwise.  I was on the fence over
whether to just remove the constness (even though the data is never
modified during its lifetime); would that be preferable?

-Scott
