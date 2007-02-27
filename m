Return-Path: <benh@kernel.crashing.org>
Subject: Re: #cpus property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070227021151.GB1861@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA302AA0181@az33exm25.fsl.freescale.net>
	<213956050aa89759f6329f518e46f42b@kernel.crashing.org>
	<20070227021151.GB1861@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 27 Feb 2007 07:48:54 +0100
Message-Id: <1172558934.11949.45.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-27 at 13:11 +1100, David Gibson wrote:
> On Tue, Feb 27, 2007 at 12:33:05AM +0100, Segher Boessenkool wrote:
> > > Anyone know the origin of the #cpus property that seems to be in most 
> > > of
> > > the DTS files.  It seems to be documented nowhere.
> > 
> > It was there in the first DTS file to hit the kernel
> > source tree.  Probably all others just copied that.
> 
> That sounds likely.  We should probably get rid of it, the kernel
> doesn't use it.  BenH, Paulus, you can't see any use for this one?

Nope.

Ben.
