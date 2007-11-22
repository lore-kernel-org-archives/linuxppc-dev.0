Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 12/14] powerpc: Add early udbg support for 40x
	processors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20071121225838.GC19445@localhost.localdomain>
References: <1195625777.579001.269266058699.qpush@grosgo>
	<20071121061720.83D5ADEBE3@ozlabs.org>
	<20071121225838.GC19445@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 22 Nov 2007 11:00:15 +1100
Message-Id: <1195689615.6970.117.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-11-22 at 09:58 +1100, David Gibson wrote:
> On Wed, Nov 21, 2007 at 05:16:30PM +1100, Benjamin Herrenschmidt wrote:
> > This adds some basic real mode based early udbg support for 40x
> > in order to debug things more easily
> 
> Shouldn't we be able to share code with the Maple realmode udbg()?

Do you really care ?

Ben.
