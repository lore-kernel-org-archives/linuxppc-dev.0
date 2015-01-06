Return-Path: <stern+54ad1fae@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by lists.ozlabs.org (Postfix) with SMTP id 3B57A1A09CF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 05:22:11 +1100 (AEDT)
Date: Tue, 6 Jan 2015 13:22:08 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Michael Tessier <michael.tessier@axiontech.ca>
Subject: RE: PROBLEM: USB isochronous urb leak on EHCI driver
In-Reply-To: <66A26A9AA227D947AF088537F041526E2009E5@VSVR-EX10-MB1.pocatec.com>
Message-ID: <Pine.LNX.4.44L0.1501061316030.1602-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 6 Jan 2015, Michael Tessier wrote:

> > > > > That is interresting, however, I have an older kernel running an 
> > > > > OHCI driver which is able to handle 4 codecs. Same usb hardware 
> > > > > (codecs and hub), but older kernel on a different CPU, with much 
> > > > > less power. This makes me believe that there's a solution to make it work...
> > > > 
> > > > Of course there is: Install an OHCI host controller and use it to drive your codecs.  It should work fine.
> 
> What do you mean by that? The host controller is embedded in the i.MX CPU...
> Changing the CPU is not really an option to me. Unless I am missing
> something?

I didn't realize you were talking about an i.MX-based system.  On a
computer with a free PCI slot, it's easy to add an OHCI controller.  
iMX isn't as accomodating.

If there's no way to add an extra USB controller to your system then 
the only choice is to upgrade the driver software.

Alan Stern
