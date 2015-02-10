Return-Path: <stern+54dcceda@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
 by lists.ozlabs.org (Postfix) with SMTP id 0341C1A01E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 03:01:34 +1100 (AEDT)
Date: Tue, 10 Feb 2015 11:01:32 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Michael Tessier <michael.tessier@axiontech.ca>
Subject: RE: PROBLEM: USB isochronous urb leak on EHCI driver
In-Reply-To: <66A26A9AA227D947AF088537F041526E224E0A@VSVR-EX10-MB1.pocatec.com>
Message-ID: <Pine.LNX.4.44L0.1502101053480.18508-100000@netrider.rowland.org>
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

On Tue, 10 Feb 2015, Michael Tessier wrote:

> > > Okay; I did my homeworks. We've loaded kernel V3.16 (Oct 14th, 2015) 
> > > on an i.MX51 plattform and the problem is still there. Unless an 
> > > important change occured in V3.19, it appears that the latest kernel 
> > > is not the solution for us. So we're still not able to use 4 codecs on 
> > > our i.MX plattform.
> > > 
> > > So just to make things clearer:
> > > - We have customers waiting for a solution with that hardware (this 
> > > hardware is already delivred AND used);
> > > - We have important comittments and severe penalties ($$$) if we're 
> > > not able to deliver on time (due for March 15th);
> > > - We've already looked at a hardware solution, which corresponds to 
> > > replace current units ($$$$$), so that is not really an option for us;
> > > 
> > > So as a last resort, I'm wondering, where is the USB expert who could 
> > > help us solving our problem? Any suggestions?
> >
> > That would be me.
> 
> Great. What do you need to make it a priority?

Let's put it this way: Fixing bugs in the ehci-hcd driver already is a
priority for me.  But it takes second place to other priorities, such
as my day job.

(And incidentally, finding and fixing bugs in kernels as old as 2.6.31
is _not_ a priority, since so many have already been found and fixed.  
That is one important reason for my suggestion that you do the
debugging with the most recent kernel version you can.)

> > > If we are to get into debugging the USB driver, we would do it with 
> > > the current kernel used (V2.6.31). What are the better tools to get 
> > > into that? I guess a USB analyzer (hardware) would be the smart thing? 
> > > Any brand name to suggest?
> >
> > It really would be better to start by debugging the most recent kernel possible.  Once the problem has been solved there, it should be fairly straightforward to port it back.
> 
> How much time do you think you'd spend solving that kind of issue?
> Few days? Few weeks, or few months?

No idea.  In the past, such things have taken a few days to a few 
weeks, depending on lots of factors -- when they are solvable at all.

>  Could you commit on a certain
> number of hours? (We are trying to evaluate a possible date where we
> could start delivering products)

No, I can't commit to anything specific.

> When you say "straightforward", again do you have an idea of the
> amount of time to do such work?

Again, it all depends.  For example, it might turn out that the 
hardware you are using contains a bug of a sort I have seen in the 
past.  In that case, programming a workaround wouldn't take more than a 
few hours, once I knew what was going on.

Alan Stern
