Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <324befe15b30886e86b0110c30334c8f@embeddededge.com>
References: <1132032910.23979.6.camel@gaston>
	<00eecfdbd5bccc7b293d847033121eee@freescale.com>
	<1132108490.5646.67.camel@gaston>
	<02de724e66fe23fd23a3635c8b6f049f@embeddededge.com>
	<1132117236.5646.75.camel@gaston>
	<324befe15b30886e86b0110c30334c8f@embeddededge.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 17:13:45 +1100
Message-Id: <1132121625.5646.77.camel@gaston>
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

On Wed, 2005-11-16 at 00:35 -0500, Dan Malek wrote:
> On Nov 16, 2005, at 12:00 AM, Benjamin Herrenschmidt wrote:
> 
> > Oh well, I suppose I'll have to dig out paulus' 601 based mac :)
> 
> If we don't have any contemporary processors that need
> this solution, can we just put on aside until someone
> has hardware that requires it?

I do not want to break an existing functionality with the merged file,
though for now, I suppose the merged file will only apply to
ARCH=powerpc, I can keep the old align.c in arch/ppc/kernel until it has
been properly tested on old machines.

Ben.
