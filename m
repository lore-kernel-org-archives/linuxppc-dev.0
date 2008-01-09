Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id B6C05DE03B
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 01:58:52 +1100 (EST)
Date: Wed, 9 Jan 2008 15:58:50 +0100
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: add phy-handle property for fec_mpc52xx
Message-ID: <20080109145850.GA4413@powerlinux.fr>
References: <20080109140608.GA15673@aepfle.de>
	<fa686aa40801090644q5d1aa117ka7e8f5aed34237bd@mail.gmail.com>
	<20080109144910.GA4222@powerlinux.fr>
	<fa686aa40801090650l38bea6a0l7a1ea2d81667f42e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40801090650l38bea6a0l7a1ea2d81667f42e@mail.gmail.com>
From: Sven Luther <sven@powerlinux.fr>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2008 at 07:50:14AM -0700, Grant Likely wrote:
> On 1/9/08, Sven Luther <sven@powerlinux.fr> wrote:
> > On Wed, Jan 09, 2008 at 07:44:58AM -0700, Grant Likely wrote:
> > > Woo!  Thanks Olaf.  I was just about to sit down and write something
> > > like this myself.  Looks good to me.  I'll pick this up (but I'm going
> > > to move it to the fixup_device_tree_efika() function)
> >
> > Indeed, thanks, this makes the efika kernel again work out of the box.
> > Would it be possible to merge this upstream asap ?
> 
> I'll see if paulus will pick it up for 2.6.24

Cool, this would mean the only thing missing the patchset i have been
carrying is the sound driver. Do you see something else that has been
added since then ? 

Friendly,

Sven Luther
