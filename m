Return-Path: <stern+54dcceda@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by lists.ozlabs.org (Postfix) with SMTP id 7E1E31A012E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:09:30 +1100 (AEDT)
Date: Mon, 9 Feb 2015 21:09:27 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Michael Tessier <michael.tessier@axiontech.ca>
Subject: RE: PROBLEM: USB isochronous urb leak on EHCI driver
In-Reply-To: <66A26A9AA227D947AF088537F041526E224CCB@VSVR-EX10-MB1.pocatec.com>
Message-ID: <Pine.LNX.4.44L0.1502092104180.3220-100000@netrider.rowland.org>
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

On Mon, 9 Feb 2015, Michael Tessier wrote:

> Okay; I did my homeworks. We've loaded kernel V3.16 (Oct 14th, 2015)
> on an i.MX51 plattform and the problem is still there. Unless an
> important change occured in V3.19, it appears that the latest kernel
> is not the solution for us. So we're still not able to use 4 codecs
> on our i.MX plattform.
> 
> So just to make things clearer:
> - We have customers waiting for a solution with that hardware (this
> hardware is already delivred AND used);
> - We have important comittments and severe penalties ($$$) if we're
> not able to deliver on time (due for March 15th);
> - We've already looked at a hardware solution, which corresponds to
> replace current units ($$$$$), so that is not really an option for
> us;
> 
> So as a last resort, I'm wondering, where is the USB expert who could
> help us solving our problem? Any suggestions?

That would be me.

> If we are to get into debugging the USB driver, we would do it with
> the current kernel used (V2.6.31). What are the better tools to get
> into that? I guess a USB analyzer (hardware) would be the smart
> thing? Any brand name to suggest?

It really would be better to start by debugging the most recent kernel
possible.  Once the problem has been solved there, it should be fairly
straightforward to port it back.

> Any other ideas for a solution will be really appreciated.

You should begin by using usbmon during a short test (one or two 
seconds ought to be enough).  See the instructions in the kernel source 
file Documentation/usb/usbmon.txt.

Alan Stern
