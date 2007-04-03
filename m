Return-Path: <mgreer@mvista.com>
Date: Tue, 3 Apr 2007 11:50:00 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Dale Farnsworth <dfarnsworth@mvista.com>
Subject: Re: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Message-ID: <20070403185000.GF16719@mag.az.mvista.com>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
	<20070329003550.GB25652@localhost.localdomain>
	<20070402181553.GH2132@mag.az.mvista.com>
	<20070403005502.GA31273@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070403005502.GA31273@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 03, 2007 at 10:55:02AM +1000, David Gibson wrote:
> On Mon, Apr 02, 2007 at 11:15:53AM -0700, Mark A. Greer wrote:
> > On Thu, Mar 29, 2007 at 10:35:50AM +1000, David Gibson wrote:
> > > On Wed, Mar 28, 2007 at 09:43:16AM -0700, Yoder Stuart-B08248 wrote:

<snip>

> > > The only thing that should need
> > > virtual-reg properties is serial ports.  In fact, specifically, only
> > > serial ports that the zImage is actually expected to use.
> > 
> > Not true.  Any reg block you're going to access in the bootwrapper needs
> > this or some equivalent method for determining where to access those regs.
> > Either that, parse BAT & page/hash tables, or provide ioremap in the
> > bootwrapper (which, at the time virtual-reg materialized, was deemed
> > overkill for the bootwrapper--presumably the same goes for parsing hash
> > tables).
> 
> And examples of such reg blocks other than serial would be...?

I2C.  Reading the MAC addr and putting into dev tree for kernel.

Mark
