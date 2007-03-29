Return-Path: <dale@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 29 Mar 2007 15:21:52 -0700
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Message-ID: <20070329222152.GB22134@xyzzy.farnsworth.org>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
	<20070329003550.GB25652@localhost.localdomain>
	<2cd6c2dd69700dd162e90f8b7a83a99d@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2cd6c2dd69700dd162e90f8b7a83a99d@kernel.crashing.org>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Dale Farnsworth <dfarnsworth@mvista.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 29, 2007 at 02:48:47AM +0200, Segher Boessenkool wrote:
> The only valid reason to use "virtual-reg" is as a
> hack to map some device to get some debug output out.
> 
> If for normal usage you can't be bothered to parse
> the current translations, you probably shouldn't be
> doing anything as "advanced" as device I/O either --
> just boot the kernel and let it handle it ;-)
> 
> That said, I sure hope the kernel isn't using this
> property as well...

I think we all agree that would be bogus.

-Dale
