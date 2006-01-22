Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 001/001] PMAC HD runtime blinking control
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
In-Reply-To: <20060122181126.357df500.cedric.pradalier@inrialpes.fr>
References: <20060122121907.792abc72.cedric.pradalier@free.fr>
	<1137898193.12998.83.camel@localhost.localdomain>
	<20060122181126.357df500.cedric.pradalier@inrialpes.fr>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 19:25:36 +1100
Message-Id: <1137918336.24244.13.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-01-22 at 18:11 +1000, Cedric Pradalier wrote:

> In ide_hwif_t, I'm using the pci_dev. Where in the pci_dev
> can I find ide0? or is it somewhere else in ide_hwif_t?

Yah, I think it's in there (in ide_hwif_t)

> For the HWIF array, I guess you're talking about ide_hwifs.
> How do I identify the interface itself there?

well, depends what you are working from...  pmif has an index into it
for example...

> Hmm, plenty of questions. I hope at least one is relevant
> for this problem...
> 
> Thanks
> --
> Cedric
