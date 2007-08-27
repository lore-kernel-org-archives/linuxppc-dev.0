Return-Path: <vitb@kernel.crashing.org>
Date: Mon, 27 Aug 2007 10:55:07 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/3] [POWERPC] Add PCI support for AMCC 440EPx (sequoia)
Message-ID: <20070827105507.768b1aad@localhost.localdomain>
In-Reply-To: <20070827015719.GD12804@localhost.localdomain>
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
	<20070825093001.4087.18160.stgit@localhost.localdomain>
	<20070827015719.GD12804@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 27 Aug 2007 11:57:19 +1000
David Gibson wrote:

> > + * Free Software Foundation;  either version 2 of the  License, or
> > (at your
> > + * option) any later version.
> > + */  
> 
> Unless there really is something peculiar about the EPx bridge
> compared to say the GP, EP and other 4xx bridges, this should have a
> more general name.
well, I'd rather extend the name once/when it would be validated to work on those GR, EP etc.
But, if preferred, it does not hurt to change all the prefixes to ppc4xx_ with such a sole implementation,
and fork() if required later.

opinions?
-- 
Sincerely, Vitaly
