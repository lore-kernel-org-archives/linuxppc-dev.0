Date: Mon, 16 Jun 2003 21:50:19 -0700
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: GPL inconsistency in arch/ppc/ocp/xlinx/
To: Tom Rini <trini@kernel.crashing.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Peter Ryser <Peter.Ryser@xilinx.com>, akuster@mvista.com,
	linuxppc-embedded@lists.linuxppc.org,
	Scott Anderson <sanders@mvista.com>,
	Paul Mackerras <paulus@samba.org>,
	Rafael Aguirre-Sacasa <Rafael.Aguirre-Sacasa@xilinx.com>
Message-id: <3EEE9E0B.87DE9E6F@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20030524201213.GA8256@lst.de> <20030612203205.GA23017@lst.de>
 <20030612205523.GI828@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm working with our legal departement on straightening the licensing issues
out. Our intention is to distribute the source code under GPL. Most likely, we
will remove

*     Xilinx products are not intended for use in life support
*     appliances, devices, or systems. Use in such applications are
*     expressly prohibited.

without replacement.

- Peter


Tom Rini wrote:

> On Thu, Jun 12, 2003 at 10:32:05PM +0200, Christoph Hellwig wrote:
> >
> > On Sat, May 24, 2003 at 10:12:13PM +0200, Christoph Hellwig wrote:
> > >
> > > you seem to have added the the directory in the topic to the
> > > LinuxPPC trees. Unfortunately they have a license consitency that
> > > basically makes them illegal to distribute, they claim to be under
> > > GPL but have the following notice:
> > >
> > > *     Xilinx products are not intended for use in life support
> > > *     appliances, devices, or systems. Use in such applications are
> > > *     expressly prohibited.
> > >
> > > Could you please contact Xilinc to clarify the license and/or remove
> > > those files from the tree? Thanks.
> >
> > As there hasn't been any answer yet I think these files should be
> > remove to ensure the linuxppc tree is legally distributable.
>
> I think you should ask someone responsible first.  And on the correct
> mailing list as well.  Armin is not responsible for this code, Scott
> Anderson is.  Armin just put it into the linuxppc-2.5 tree.  Second,
> Peter Ryser (who handles the Xilinx side of things) is on the
> linuxppc-embedded list, where most of the 4xx people are.  Finally,
> Peter knows about this, and last I knew was talking to their legal
> department.  Peter, any news on this?
>
> --
> Tom Rini
> http://gate.crashing.org/~trini/
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
