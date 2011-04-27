Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Amit Shah <amit.shah@redhat.com>, Greg KH <greg@kroah.com>
Subject: Re: hvc_console: Don't access hvc_task if not initialised
In-Reply-To: <20110420170610.GA6013@amit-x200.redhat.com>
References: <df8ea6d65c1ceeb25b0a3fdfc66995b8a8273ea5.1300951793.git.amit.shah@redhat.com>
	<hvc-kick-notask@mdm.bga.com>
	<20110325084714.GA28356@amit-x200.redhat.com>
	<hvc-kick-notask-2@mdm.bga.com>
	<20110420123330.GB3519@amit-x200.redhat.com>
	<20110420143435.GB22436@kroah.com>
	<20110420170610.GA6013@amit-x200.redhat.com>
Date: Wed, 27 Apr 2011 14:31:29 +0930
Message-ID: <87oc3sl23a.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 20 Apr 2011 22:36:10 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> On (Wed) 20 Apr 2011 [07:34:35], Greg KH wrote:
> > Care to either create this patch, or resend your original one, if you
> > want it applied?
> 
> Rusty has the other one queued.  I pinged him about status.

It's merged, but I don't think it had the requisite cc:stable, did it?

Thanks,
Rusty.
