Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <02de724e66fe23fd23a3635c8b6f049f@embeddededge.com>
References: <1132032910.23979.6.camel@gaston>
	<00eecfdbd5bccc7b293d847033121eee@freescale.com>
	<1132108490.5646.67.camel@gaston>
	<02de724e66fe23fd23a3635c8b6f049f@embeddededge.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 16:00:35 +1100
Message-Id: <1132117236.5646.75.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Merge align.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-11-15 at 23:26 -0500, Dan Malek wrote:
> On Nov 15, 2005, at 9:34 PM, Benjamin Herrenschmidt wrote:
> 
> > What about lwz/stw cropssing page boundaries ? Is this handled in HW ?
> 
> Yep.  All of these hardware alignment support features on
> the Freescale processors are the reasons they are used
> so extensively in data communication processing (where
> unaligned data can sometimes occur).  All of the load/store
> alignment issues are handled in the cache subsystem, so
> to the external world all you really see are cache line
> operations.  In the event of uncached data operations, you
> get the performance penalty of two bus accesses, where
> some of the data is discarded.

Oh well, I suppose I'll have to dig out paulus' 601 based mac :)

Becky, can you send me a copy of your testcase ?

Ben.
