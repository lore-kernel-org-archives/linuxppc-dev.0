Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id 91801DDF00
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 10:54:14 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2657637rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jul 2008 17:54:12 -0700 (PDT)
Date: Tue, 8 Jul 2008 18:54:09 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: [PATCH v2] Add MPC5200B base board mvBC-P
Message-ID: <20080709005409.GD12502@secretlab.ca>
References: <4871D065.8080709@matrix-vision.de>
	<20080708034427.GD1549@yookeroo.seuss>
	<48732588.8020907@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48732588.8020907@matrix-vision.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 08, 2008 at 10:30:00AM +0200, Andre Schwarz wrote:
> David Gibson schrieb:
> > On Mon, Jul 07, 2008 at 10:14:29AM +0200, Andre Schwarz wrote:
> >   
> >> The mvBlueCOUGAR-P is a MPC5200B based camera system with Intel Gigabit ethernet
> >> controller (using e1000). It's just another MPC5200_simple board.
> >>     
> >
> > [snip]
> >   
> >> +		timer@600 {	// General Purpose Timer
> >> +			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> >> +			reg = <0x600 0x10>;
> >> +			interrupts = <1 9 0>;
> >> +			interrupt-parent = <&mpc5200_pic>;
> >> +			fsl,has-wdt;
> >> +		};
> >> +
> >> +		timer@610 {	// General Purpose Timer
> >> +			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> >> +			cell-index = <1>;
> >>     
> >
> > What shared resource is this cell-index value used to index?
> >
> > Also why does it not appear on the timer@600 but does on all the
> > others.
> >
> >   
> Sorry - it's a copy paste problem. At first I only used timer0, i.e.
> this is the original entry.
> After Grant wanting me to have a look at the lite5200b.dts I copied over
> the rest of the dts nodes I also have on my board. On lite5200b.dts the
> cell-index is defined.
> 
> If this is incorrect I'll remove it.
> Is cell-index inappropriate for the timer node ?

Yes, you can drop cell-index for fsl,mpc5200-gpt nodes.

g.
