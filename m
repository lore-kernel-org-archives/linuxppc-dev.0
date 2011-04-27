Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id C51ACB6EF3
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Apr 2011 16:31:55 +1000 (EST)
Date: Wed, 27 Apr 2011 12:01:47 +0530
From: Amit Shah <amit.shah@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: hvc_console: Don't access hvc_task if not initialised
Message-ID: <20110427063147.GA28328@amit-x200.redhat.com>
References: <df8ea6d65c1ceeb25b0a3fdfc66995b8a8273ea5.1300951793.git.amit.shah@redhat.com>
	<hvc-kick-notask@mdm.bga.com>
	<20110325084714.GA28356@amit-x200.redhat.com>
	<hvc-kick-notask-2@mdm.bga.com>
	<20110420123330.GB3519@amit-x200.redhat.com>
	<20110420143435.GB22436@kroah.com>
	<20110420170610.GA6013@amit-x200.redhat.com>
	<87oc3sl23a.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87oc3sl23a.fsf@rustcorp.com.au>
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (Wed) 27 Apr 2011 [14:31:29], Rusty Russell wrote:
> On Wed, 20 Apr 2011 22:36:10 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> > On (Wed) 20 Apr 2011 [07:34:35], Greg KH wrote:
> > > Care to either create this patch, or resend your original one, if you
> > > want it applied?
> > 
> > Rusty has the other one queued.  I pinged him about status.
> 
> It's merged, but I don't think it had the requisite cc:stable, did it?

No, because at the point of submitting I didn't know it would solve
this bug as well.  Greg, can you pick
afa2689e19073cd2e762d0f2c1358fab1ab9f18c for stable?

Thanks,

		Amit
