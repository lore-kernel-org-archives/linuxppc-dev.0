Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp4.wanadoo.fr (smtp4.wanadoo.fr [193.252.22.27])
	by ozlabs.org (Postfix) with ESMTP id 4099F2BDB5
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Dec 2004 20:48:50 +1100 (EST)
Date: Fri, 31 Dec 2004 10:55:57 +0100
To: Christian <evilninja@gmx.net>
Message-ID: <20041231095557.GA16480@pegasos>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<41CF77A9.9040405@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <41CF77A9.9040405@gmx.net>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org,
	Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 27, 2004 at 03:47:05AM +0100, Christian wrote:
> Marc Dietrich schrieb:
> >Hi all,
> >
> >I read this thread about booting a PowerStack with newer kernels. 
> >Motivated by this, I tried to compile a 2.6.10 kernel on my machine (with 
> >sym53c825a onboard). Sadly, the scsi controller always timeouts during 
> >initialisation. I 

I also have some strange issues with network support using the standard debian
2.6.8 kernel. ifconfig upping the decchip ethernet on the powerstack freezes
the kernel, and i hear reports of problems on IBM PReP hardware too with not
working ethernet, altough there is no freeze.

Any idea on this ? 

Friendly,

Sven Luther
