Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 038C2B71AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Feb 2011 03:53:32 +1100 (EST)
Date: Mon, 14 Feb 2011 08:53:27 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC] Inter-processor Mailboxes Drivers
Message-ID: <20110214165327.GB13271@ovro.caltech.edu>
References: <4D55A7F7.5090700@mentor.com>
	<20110214100104.GC4371@pulham.picochip.com>
	<AANLkTinu9VMuFgHeFZGXptDYZyJL6P4qxAA9MA8UewpU@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTinu9VMuFgHeFZGXptDYZyJL6P4qxAA9MA8UewpU@mail.gmail.com>
Cc: Meador Inge <meador_inge@mentor.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
	"Blanchard, Hollis" <Hollis_Blanchard@mentor.com>,
	openmcapi-dev@googlegroups.com, Jamie Iles <jamie@jamieiles.com>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 14, 2011 at 12:03:59PM +0200, Ohad Ben-Cohen wrote:
> On Mon, Feb 14, 2011 at 12:01 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> > On Fri, Feb 11, 2011 at 03:19:51PM -0600, Meador Inge wrote:
> >>     1. Hardware specific bits somewhere under '.../arch/*'.  Drivers
> >>        for the MPIC message registers on Power and OMAP4 mailboxes, for
> >>        example.
> >>     2. A higher level driver under '.../drivers/mailbox/*'.  That the
> >>        pieces in (1) would register with.  This piece would expose the
> >>        main kernel API.
> >>     3. Userspace interfaces for accessing the mailboxes.  A
> >>        '/dev/mailbox1', '/dev/mailbox2', etc... mapping, for example.
> >
> > How about using virtio for all of this and having the mailbox as a
> > notification/message passing driver for the virtio backend?
> 
> This is exactly what we are doing now, and it looks promising. expect
> patches soon.

I'll be happy to examine the feasibility of doing a port to mpc83xx as
soon as I see the code. :-) I have been using the message registers to
create a software "network card" over PCI (between a host system and an
mpc83xx in a PCI slot). I have wanted to use virtio for this task for a
long time.

I think a uniform interface for the mailbox registers would be a very
useful API.

Thanks,
Ira
