Return-Path: <iws@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7FF56B715D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 01:10:17 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id B6C33DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 01:10:16 +1000 (EST)
Date: Thu, 11 Jun 2009 08:10:13 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC v2] virtio: add virtio-over-PCI driver
Message-ID: <20090611151013.GA9323@ovro.caltech.edu>
References: <20090224000002.GA578@ovro.caltech.edu>
	<fa686aa40904141328oa57fb1bsffd0549a52eca90@mail.gmail.com>
	<20090414215342.GB9877@ovro.caltech.edu>
	<fa686aa40906110722y1b4b8c22l7ccdd32d6684324d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fa686aa40906110722y1b4b8c22l7ccdd32d6684324d@mail.gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 11, 2009 at 08:22:54AM -0600, Grant Likely wrote:
> On Tue, Apr 14, 2009 at 3:53 PM, Ira Snyder<iws@ovro.caltech.edu> wrote:
> > On Tue, Apr 14, 2009 at 02:28:26PM -0600, Grant Likely wrote:
> >> On Mon, Feb 23, 2009 at 6:00 PM, Ira Snyder <iws@ovro.caltech.edu> wrote:
> >> > This adds support to Linux for using virtio between two computers linked by
> >> > a PCI interface. This allows the use of virtio_net to create a familiar,
> >> > fast interface for communication. It should be possible to use other virtio
> >> > devices in the future, but this has not been tested.
> >>
> >> Hey Ira,
> >>
> >> I like this a lot.  I need to do much the same thing on one of my
> >> platforms, so I'm going to use your patch as my starting point.  Have
> >> you made many changes since you posted this version of your patch?
> >> I'd like to collaborate on the development and help to get it
> >> mainlined.
> >>
> >
> > This would be great. I'd really appreciate the help. I haven't had time
> > to make any changes since I last posted the patch. I started work on
> > converting all of the usage of struct vop_loc_* to just use the on-wire
> > structures, but I didn't get very far before other work got in the way.
> >
> >> In my case I've got an MPC5200 as the 'host' and a Xilinx Virtex
> >> (ppc440) as the 'client'.  I intend set aside a region of the Xilinx
> >> Virtex's memory space for the shared queues.  I'm starting work on it
> >> now, and I'll provide you with feedback and/or patches as I make
> >> progress.
> >>
> >
> > I'm looking forward to seeing your implementation. If you have any
> > questions, I'd be happy to attempt to answer them :)
> 
> Hey Ira,
> 
> I've been slowly hacking on your virtio-over-pci stuff.  I've got an
> initial series of cleanup patches which address some of the comments
> from this thread.  Before I send them to you, have you made any
> changes on your end?  They likely won't apply without changes to the
> core code, so I'd like to sync up with you first.
> 

I haven't made any changes to the code since you've last seen it. I've
been busy with other stuff for quite a while now. I can't wait to see
what you've done :)

At least for the use of the 83xx DMA controller, the DMA_SLAVE mode
patch I posted up about a week ago (to the ppcdev list) could make the
DMA setup much simpler. It hasn't been accepted to mainline yet.

Ira
