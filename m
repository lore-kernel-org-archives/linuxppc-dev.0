Return-Path: <prvs=47567d9d1=michael.tessier@axiontech.ca>
Received: from mail.axiontech.ca (unknown [207.164.255.36])
 by lists.ozlabs.org (Postfix) with ESMTP id 829751A0257
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 10:21:48 +1100 (AEDT)
From: Michael Tessier <michael.tessier@axiontech.ca>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: PROBLEM: USB isochronous urb leak on EHCI driver
Date: Mon, 9 Feb 2015 23:21:45 +0000
Message-ID: <66A26A9AA227D947AF088537F041526E224CCB@VSVR-EX10-MB1.pocatec.com>
References: <66A26A9AA227D947AF088537F041526E2009E5@VSVR-EX10-MB1.pocatec.com>
 <Pine.LNX.4.44L0.1501061316030.1602-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1501061316030.1602-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
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


> > > > > > That is interresting, however, I have an older kernel running=20
> > > > > > an OHCI driver which is able to handle 4 codecs. Same usb=20
> > > > > > hardware (codecs and hub), but older kernel on a different=20
> > > > > > CPU, with much less power. This makes me believe that there's a=
 solution to make it work...
> > > > >=20
> > > > > Of course there is: Install an OHCI host controller and use it to=
 drive your codecs.  It should work fine.
> >=20
> > What do you mean by that? The host controller is embedded in the i.MX C=
PU...
> > Changing the CPU is not really an option to me. Unless I am missing=20
> > something?
>
> I didn't realize you were talking about an i.MX-based system.  On a compu=
ter with a free PCI slot, it's easy to add an OHCI controller. =20
> iMX isn't as accomodating.
>
> If there's no way to add an extra USB controller to your system then the =
only choice is to upgrade the driver software.
>
> Alan Stern

Okay; I did my homeworks. We've loaded kernel V3.16 (Oct 14th, 2015) on an =
i.MX51 plattform and the problem is still there. Unless an important change=
 occured in V3.19, it appears that the latest kernel is not the solution fo=
r us. So we're still not able to use 4 codecs on our i.MX plattform.

So just to make things clearer:
- We have customers waiting for a solution with that hardware (this hardwar=
e is already delivred AND used);
- We have important comittments and severe penalties ($$$) if we're not abl=
e to deliver on time (due for March 15th);
- We've already looked at a hardware solution, which corresponds to replace=
 current units ($$$$$), so that is not really an option for us;

So as a last resort, I'm wondering, where is the USB expert who could help =
us solving our problem? Any suggestions?

If we are to get into debugging the USB driver, we would do it with the cur=
rent kernel used (V2.6.31). What are the better tools to get into that? I g=
uess a USB analyzer (hardware) would be the smart thing? Any brand name to =
suggest?

Any other ideas for a solution will be really appreciated.

Regards,
Michael Tessier.
