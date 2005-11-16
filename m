Return-Path: <paubert@iram.es>
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 16 Nov 2005 20:45:53 +0100
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20051116194553.GA23679@iram.es>
References: <1132032910.23979.6.camel@gaston>
	<00eecfdbd5bccc7b293d847033121eee@freescale.com>
	<20051116093609.GA26269@iram.es>
	<43D0A21D-89BC-4EFE-BA2A-94760BA32276@kernel.crashing.org>
	<755b1bfb034aebb5de36dc0594e08ec6@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <755b1bfb034aebb5de36dc0594e08ec6@embeddededge.com>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Merge align.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 16, 2005 at 02:20:43PM -0500, Dan Malek wrote:
> 
> On Nov 16, 2005, at 10:15 AM, Kumar Gala wrote:
> 
> >603 is used in all 82xx/83xx processors from Freescale. The 8641 is 
> >the same core as 7448.
> 
> The 82xx uses G2_LE, and 83xx is e300, which are
> similar to the old 603 but do have some subtle
> improvements that make them better cores.

I originally asked because I believed that these cores are 
actually closer to the 603e than to the original 603.

But take this with a pinch of salt, I might be wrong.

	Gabriel
