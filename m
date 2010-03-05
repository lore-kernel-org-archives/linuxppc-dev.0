Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC: PATCH 08/13] powerpc/476: define specific cpu table
	entry for DD1 and DD1.1 cores
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C84D9A35-C618-47FB-A95C-73B8B940BC7C@kernel.crashing.org>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
	<20100301191351.20987.49730.sendpatchset@norville.austin.ibm.com>
	<fb412d761003040906i57842fc3t48693d5e5e777176@mail.gmail.com>
	<C84D9A35-C618-47FB-A95C-73B8B940BC7C@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 05 Mar 2010 07:18:50 -0600
Message-Id: <1267795130.28250.7.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>,
	Hollis Blanchard <hollis@penguinppc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-03-05 at 03:15 -0600, Kumar Gala wrote:
> On Mar 4, 2010, at 11:06 AM, Hollis Blanchard wrote:
> 
> > On Mon, Mar 1, 2010 at 11:13 AM, Dave Kleikamp <shaggy@linux.vnet.ibm.com> wrote:
> > powerpc/476: define specific cpu table entry for DD1 and DD1.1 cores
> > 
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > There are still some unstable bits on the DD1 and DD1.1 cores.  Don't use
> > the FPU or the tlbivax operation.  Define CPU_FTR_476_DD1 and
> > CPU_FTR_476_DD1_1 for additional workarounds in later patches.
> > 
> > The DD1 core requires workarounds triggered by both CPU_FTR_476_DD1
> > and CPU_FTR_476_DD1_1.  the DD1.1 core only needs CPU_FTR_476_DD1_1
> > defined.
> > 
> > Isn't the policy generally not to commit workarounds for
> early/errataful hardware which will not be seen in the real world?
> Otherwise, every new half-broken core could burn a bunch of feature
> bits...
> > 
> > -Hollis
> 
> I'm with Hollis.  Cluttering the code with non-production errata could
> get very ugly as well as burning feature bits up like made.

Ben's going to make the decision on whether or not these patches should
be included into mainline.  I'd be happy maintaining them separately if
not.  I'm separating out the DD1 workaround from the others, since it's
less likely that one will be needed long-term.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center
