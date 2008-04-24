Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by ozlabs.org (Postfix) with ESMTP id 55EC4DDEF0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 13:08:23 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so3422956pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 20:08:22 -0700 (PDT)
Subject: Re: simpleboot
From: Josh Boyer <jwboyer@gmail.com>
To: "David H. Lynch Jr." <dhlii@picocomputing.net>
In-Reply-To: <480FEA44.8090105@picocomputing.net>
References: <480F8148.8090906@picocomputing.net>
	<fa686aa40804231149j344a4cc5iaf15ac12828146f7@mail.gmail.com>
	<480F917F.8040809@picocomputing.net>
	<1208999357.2946.6.camel@vader.jdub.homelinux.org>
	<480FEA44.8090105@picocomputing.net>
Content-Type: text/plain
Date: Wed, 23 Apr 2008 22:08:19 -0500
Message-Id: <1209006499.2946.13.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2008-04-23 at 22:02 -0400, David H. Lynch Jr. wrote:
> Josh Boyer wrote:
> > simpleboot is in Linus' tree now.  It went in with the first pull
> > request paulus sent for .26.
> >   
>     I got it, now to figure it out.
> > I don't understand that comment anyway though.  If you're working with a
> > PowerPC board, why aren't you using the powerpc tree (paulus') to begin
> > with?  "Backporting" pieces of it to some other tree seems to be a waste
> > of time to me...
> >   
>     I am updating a port I did in 2005 ? based on the  ml403 port that
> was in at that time.
>     But it is an independent BSP. I need to move it to the current
> powerpc/devicetree,
>     but I have to do so without breaking alot of things we have have
> working for years.

OK... and how does that dictate whether to use Linus' tree or paulus'
tree?  Both are going to contain roughly the same amount of changes,
with the exception that paulus' tree will have more of the PowerPC
commits in it, including the Xilinx ml403 stuff from Grant.

>     At the moment I am somewhat "surely" about a number of the issues
> related to the powerpc/devicetree migration.
>     Aside from the BSP issues, this breaks my boot monitor, and is going
> to require adding alot more code than I can either justify
>     or see as necescary because there are some aspects of how the
> devicetree/powerpc stuff is architected that
>     politely I think are brain dead.

I don't mind people calling it brain dead.  But if you were being
polite, you'd call it brain dead and then actually list the issues so
they could be discussed.  Others might benefit from that discussion.

josh
