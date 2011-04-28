Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 5FBF51007D7
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Apr 2011 14:00:14 +1000 (EST)
Date: Thu, 28 Apr 2011 09:30:00 +0530
From: Amit Shah <amit.shah@redhat.com>
To: Greg KH <greg@kroah.com>
Subject: Re: hvc_console: Don't access hvc_task if not initialised
Message-ID: <20110428040000.GA16167@amit-x200.redhat.com>
References: <df8ea6d65c1ceeb25b0a3fdfc66995b8a8273ea5.1300951793.git.amit.shah@redhat.com>
	<hvc-kick-notask@mdm.bga.com>
	<20110325084714.GA28356@amit-x200.redhat.com>
	<hvc-kick-notask-2@mdm.bga.com>
	<20110420123330.GB3519@amit-x200.redhat.com>
	<20110420143435.GB22436@kroah.com>
	<20110420170610.GA6013@amit-x200.redhat.com>
	<87oc3sl23a.fsf@rustcorp.com.au>
	<20110427063147.GA28328@amit-x200.redhat.com>
	<20110428000934.GA14294@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110428000934.GA14294@kroah.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (Wed) 27 Apr 2011 [17:09:34], Greg KH wrote:
> On Wed, Apr 27, 2011 at 12:01:47PM +0530, Amit Shah wrote:
> > On (Wed) 27 Apr 2011 [14:31:29], Rusty Russell wrote:
> > > On Wed, 20 Apr 2011 22:36:10 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> > > > On (Wed) 20 Apr 2011 [07:34:35], Greg KH wrote:
> > > > > Care to either create this patch, or resend your original one, if you
> > > > > want it applied?
> > > > 
> > > > Rusty has the other one queued.  I pinged him about status.
> > > 
> > > It's merged, but I don't think it had the requisite cc:stable, did it?
> > 
> > No, because at the point of submitting I didn't know it would solve
> > this bug as well.  Greg, can you pick
> > afa2689e19073cd2e762d0f2c1358fab1ab9f18c for stable?
> 
> Yes, but in the future, this is NOT the way to get patches into the
> stable tree.  Please read Documentation/stable_kernel_rules.txt for how
> to do it properly.

Got it, thanks!

		Amit
