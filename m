Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 6EC88DDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 09:09:07 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so139715anc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 14:09:06 -0800 (PST)
Message-ID: <fa686aa40711261409s1535d2b8m3a58e90bcc2206a7@mail.gmail.com>
Date: Mon, 26 Nov 2007 15:09:06 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: Xilinx devicetrees
In-Reply-To: <20071126215615.73F4B1138066@mail175-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47480CF0.7090105@dlasys.net>
	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>
	<47493D4F.4070605@dlasys.net>
	<fa686aa40711251421q38f53ee3hb2a308cc5f93183f@mail.gmail.com>
	<4749FD5E.7000408@dlasys.net>
	<20071125235855.95B9999804D@mail138-cpk.bigfish.com>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A58E4@XMBIL132.northgrum.com>
	<474B37C9.8020405@dlasystems.com>
	<20071126215615.73F4B1138066@mail175-dub.bigfish.com>
Cc: "Koss, Mike \(Mission Systems\)" <mike.koss@ngc.com>,
	"David H. Lynch Jr." <dhlii@dlasystems.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/26/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>
>
> > -----Original Message-----
> > From: David H. Lynch Jr. [mailto:dhlii@dlasystems.com]
> > Sent: Monday, November 26, 2007 1:17 PM
> > To: Koss, Mike (Mission Systems)
> > Cc: Stephen Neuendorffer; Grant Likely; linuxppc-embedded
> > Subject: Re: Xilinx devicetrees
> >
> >      My objective is to get alot of software - linux, GHS, and
> > standalone apps, to all load - from a single executables, accross
> > multiple different bit images on several different (though
> > deliberately
> > similar) products. My Linux kernel needs to work regardless
> > of the Pico
> > card and regardless of the bit image, as done my GHS kernel, and ....
> > And I need to do that in a severly resource constrained environment.
> >     I would hope that should make sense of my harping about
> > version/capabilities registers. If I have maybe 10 possible
> > peices of IP
> > that may/maynot be present in a given FPGA and I am trying to
> > dynamically configure - Linux/GHS/... to adapt to whatever it
> > encounters
> > and work as long as it is a viable combination. At best
> > devicetrees are
> > an extremly complex way of solving that - while version
> > registers are a
> > trivial way.

I disagree.  I'm not disputing that version registers are valuable.
But I *am* disputing their value for device detection.  It may work in
your specific case of devices always in certain locations, but it does
not help the general case where devices can be instantiated anywhere
in the 4GB address space.

>
> It sounds like the real problem that you have is that even if you get
> device trees working for Linux, you still have the same problem for GHS,
> so from your perspective "device trees don't help"

In embedded power.org land, device trees are becoming the recommended
method for describing platform configuration for all embedded powerpc
software.  Not just Linux.  So from that perspective device trees
might help.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
