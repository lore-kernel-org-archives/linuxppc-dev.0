Return-Path: <prvs=4765b6b91=michael.tessier@axiontech.ca>
Received: from mail.axiontech.ca (unknown [207.164.255.36])
 by lists.ozlabs.org (Postfix) with ESMTP id 00B001A0283
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 02:11:03 +1100 (AEDT)
From: Michael Tessier <michael.tessier@axiontech.ca>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: PROBLEM: USB isochronous urb leak on EHCI driver
Date: Tue, 10 Feb 2015 15:11:00 +0000
Message-ID: <66A26A9AA227D947AF088537F041526E224E0A@VSVR-EX10-MB1.pocatec.com>
References: <66A26A9AA227D947AF088537F041526E224CCB@VSVR-EX10-MB1.pocatec.com>
 <Pine.LNX.4.44L0.1502092104180.3220-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1502092104180.3220-100000@netrider.rowland.org>
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

> > Okay; I did my homeworks. We've loaded kernel V3.16 (Oct 14th, 2015)=20
> > on an i.MX51 plattform and the problem is still there. Unless an=20
> > important change occured in V3.19, it appears that the latest kernel=20
> > is not the solution for us. So we're still not able to use 4 codecs on=
=20
> > our i.MX plattform.
> >=20
> > So just to make things clearer:
> > - We have customers waiting for a solution with that hardware (this=20
> > hardware is already delivred AND used);
> > - We have important comittments and severe penalties ($$$) if we're=20
> > not able to deliver on time (due for March 15th);
> > - We've already looked at a hardware solution, which corresponds to=20
> > replace current units ($$$$$), so that is not really an option for us;
> >=20
> > So as a last resort, I'm wondering, where is the USB expert who could=20
> > help us solving our problem? Any suggestions?
>
> That would be me.

Great. What do you need to make it a priority?

>
> > If we are to get into debugging the USB driver, we would do it with=20
> > the current kernel used (V2.6.31). What are the better tools to get=20
> > into that? I guess a USB analyzer (hardware) would be the smart thing?=
=20
> > Any brand name to suggest?
>
> It really would be better to start by debugging the most recent kernel po=
ssible.  Once the problem has been solved there, it should be fairly straig=
htforward to port it back.

How much time do you think you'd spend solving that kind of issue? Few days=
? Few weeks, or few months? Could you commit on a certain number of hours? =
(We are trying to evaluate a possible date where we could start delivering =
products)

When you say "straightforward", again do you have an idea of the amount of =
time to do such work?

> > Any other ideas for a solution will be really appreciated.
>
> You should begin by using usbmon during a short test (one or two seconds =
ought to be enough).  See the instructions in the kernel source file Docume=
ntation/usb/usbmon.txt.
>

Thanks for your support,
Michael Tessier
