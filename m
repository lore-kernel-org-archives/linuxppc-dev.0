Return-Path: <trini@kernel.crashing.org>
Date: Sat, 22 Jul 2006 08:04:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 0/6] bootwrapper: arch/powerpc/boot code reorg patches
Message-ID: <20060722150452.GH24522@smtp.west.cox.net>
References: <20060719225356.GA3887@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060719225356.GA3887@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 19, 2006 at 03:53:56PM -0700, Mark A. Greer wrote:

> The following emails from me in this thread are the latest set of
> patches that reorg the bootwrapper code so that OF and non-OF
> platforms can live together.
> 
> I punted somewhat on "The Tool" that's been talked about that takes a
> kernel and attaches a flattened device tree (fdt) to it.  I thought
> about it for a while but I think we need to clarify the requirements
> better before it makes sense to spend a lot of cycles on it.

Great!  As the last person to know what all this code was doing in
arch/ppc/boot, I'll try and give it all a review..

-- 
Tom Rini
