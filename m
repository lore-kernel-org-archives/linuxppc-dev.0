Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 551FF2BF18
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 08:28:51 +1100 (EST)
Date: Wed, 12 Jan 2005 14:28:31 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Kumar Gala <galak@somerset.sps.mot.com>,
	trini@kernel.crashing.org, linuxppc-embedded@ozlabs.org,
	jason.mcmullan@timesys.com
Message-ID: <20050112142831.D22626@home.com>
References: <Pine.LNX.4.61.0501120133080.21665@blarg.somerset.sps.mot.com>
	<20050112083637.GA13794@gate.ebshome.net>
	<20050112141449.B22626@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050112141449.B22626@home.com>;
	from mporter@kernel.crashing.org on Wed, Jan 12, 2005 at
	02:14:49PM -0700
Subject: Re: RFC: [PATCH] platform device driver model support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 12, 2005 at 02:14:49PM -0700, Matt Porter wrote:
> On Wed, Jan 12, 2005 at 12:36:37AM -0800, Eugene Surovegin wrote:
> > IMHO, ppc_soc_update_paddr - is a very confusing name, in fact, from 
> > first read I though it _changes_ paddr to the new value, not _adds_ it 
> > :)
> 
> I think it should be ppc_soc_update_mem_resource() or some such.
> You are updating the IOMEM resource.

More IRC chatter and ppc_soc_fixup_mem_resource() seems to be more
descriptive.

-Matt
