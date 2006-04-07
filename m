Return-Path: <olof@lixom.net>
Date: Fri, 7 Apr 2006 11:20:26 -0500
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [Cbe-oss-dev] [PATCH 4/5] powerpc: export symbols for page size
	selection
Message-ID: <20060407162026.GK952@pb15.lixom.net>
References: <20060407150124.422051000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060407152813.GA382@lst.de> <20060407154247.GJ952@pb15.lixom.net>
	<200604071803.01836.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200604071803.01836.arnd.bergmann@de.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 07, 2006 at 06:03:01PM +0200, Arnd Bergmann wrote:
> On Friday 07 April 2006 17:42, Olof Johansson wrote:
> > Yeah, what's the need for that, really? It needs to know so much of
> > kernel internals that it's getting silly to allow it to be a module.
>
> How about if I do a patch that always includes the base but not
> the actual file system?

Sounds like a decent tradeoff.


-Olof
