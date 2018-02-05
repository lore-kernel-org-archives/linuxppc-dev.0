Return-Path: <segher@gate.crashing.org>
Date: Mon, 5 Feb 2018 08:41:18 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH (skiboot)] dt: add /cpus/ibm,
 powerpc-cpu-features device tree bindings
Message-ID: <20180205144116.GU21977@gate.crashing.org>
References: <20180203042732.27980-1-npiggin@gmail.com>
 <20180203153620.GP21977@gate.crashing.org>
 <20180205112615.4f267659@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180205112615.4f267659@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 05, 2018 at 11:26:15AM +1000, Nicholas Piggin wrote:
> On Sat, 3 Feb 2018 09:36:20 -0600
> > On Sat, Feb 03, 2018 at 02:27:32PM +1000, Nicholas Piggin wrote:
> > > +	/*
> > > +	 * ISAv3.0B branch instruction and register additions
> > > +	 * CA32, OV32, mcrxrx, setb
> > > +	 */
> > > +	{ "branch-v3",  
> > 
> > Those aren't branch instructions, they are integer instructions.  Some
> > of which use the XER, some of which use CR fields.
> 
> Okay, well the register changes are for branch facility registers, I
> guess instructions could move to integer. We have nothing relying on
> exact definition of these things at the moment, so these we can change.

XER is a fixed-point facility register (that's what the "X" means even!)

Thanks,


Segher
