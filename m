Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BC792DDE1E
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 10:25:59 +1100 (EST)
Date: Sun, 6 Jan 2008 16:55:09 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] Return a non-zero exit code if an error occurs during
	dts parsing.
Message-ID: <20080106225509.GC8239@ld0162-tx32.am.freescale.net>
References: <20080103234333.GC8441@ld0162-tx32.am.freescale.net>
	<20080104043033.GD4326@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080104043033.GD4326@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 04, 2008 at 03:30:33PM +1100, David Gibson wrote:
> This is unequivocally wrong.  boot_info should have information about
> the contents of the blob, not state information like the error.

"This blob is invalid" *is* information about the contents of the blob.

> If you're going to use an ugly global, then use it everywhere.

Why go out of our way to make the code even less library-able/thread-safe?

-Scott
