Return-Path: <jwboyer@linux.vnet.ibm.com>
Subject: Re: [CURIOUSITY] When will we stop caring about arch/ppc?
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0FBD8D7C-1A60-4305-992C-5C28ECE41278@kernel.crashing.org>
References: <20070625182304.GC31840@mag.az.mvista.com>
	<1182796800.23775.51.camel@weaponx.rchland.ibm.com>
	<0FBD8D7C-1A60-4305-992C-5C28ECE41278@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 15:50:09 -0500
Message-Id: <1182804609.20939.5.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-25 at 14:42 -0500, Kumar Gala wrote:
> On Jun 25, 2007, at 1:40 PM, Josh Boyer wrote:
> 
> > On Mon, 2007-06-25 at 11:23 -0700, Mark A. Greer wrote:
> >> Any opinions on when we stop worrying about arch/ppc and start  
> >> getting
> >> rid of it for real?
> >
> > There are lots of boards in the 4xx family that don't exist yet in
> > powerpc.  I don't think we want it to die until they get moved  
> > over, or
> > at least marked as in a "danger zone" for a while.
> 
> Agreed, we need to go through and figure out what all really needs to  
> get moved over for other boards.  I know 4xx has only one board  
> supported in arch/powerpc and I dont believe the support is complete.

Right.  Ebony boots at least.  Needs PCI to be completed.  There are
lots of other 44x boards that should probably be brought over and are in
various stages of completion.  Bamboo, Taishan, Sequoia, Katmai, etc.

For 40x, I hope to get working on a Walnut port soon.  Not sure much
else is really needed there.

There's also the Xilinx boards.

> > Maybe what we could do is designate a kernel release where we'll stop
> > taking new arch/ppc submissions?
> 
> I think we stopped taking new submissions to arch/ppc a while ago...  
> someone sneak something in on us?  We tend to only do bug fixes or  
> deal with issues related to moving things between arch/ppc & arch/ 
> powerpc.

Well, there's definitely been an aversion to it.  But I meant adding
something in the Documentation/powerpc/ directory and maybe
feature-removal-schedule.txt.  Basically a written down thing in the
kernel source to refer people to.

josh
