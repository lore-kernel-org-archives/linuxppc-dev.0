Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from IE1EHSOBE001.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 03C9DDDF3F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Sep 2008 04:04:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Back port Virtex5 FPU to Virtex4?
Date: Wed, 17 Sep 2008 11:03:56 -0700
In-Reply-To: <20080917173555.GA7913@secretlab.ca>
References: <3C87E4F8-3DA2-41E8-BE33-979A7869FD2D@gmail.com>
	<20080917173555.GA7913@secretlab.ca>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Shanyuan Gao" <sygao.research@gmail.com>
Message-ID: <20080917180357.2C91B7F8080@mail38-dub.bigfish.com>
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


Sorry, I missed your original question:

There's a very complex tradeoff with these cores, in terms of clock
speed of the processor, clock speed of the FPU, errata workarounds, etc.
Generally, In V4, DP floating point code ends up about the same speed
whether you use the DP core and accept the system limitations or just
use a well tuned DP floating point emulation library with the core
frequency as fast as possible: hence we usually recommend for most
purposes, people use the floating point emulation libraries in V4 for
double precision.   My understanding is that the IBM libraries are
significantly better than the gcc libraries in this respect...

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Grant
Likely
> Sent: Wednesday, September 17, 2008 10:36 AM
> To: Shanyuan Gao
> Cc: linuxppc-embedded
> Subject: Re: Back port Virtex5 FPU to Virtex4?
> =

> On Tue, Aug 26, 2008 at 04:00:42PM -0400, Shanyuan Gao wrote:
> > I am working with ML410 and have FPU (single precision) working.
> > However, the FPU for V5 looks more attractive because it's double
> > precision.  So is it possible to back port the double precision FPU
to
> > V4?
> =

> As far as I understand there are limitations in the V4 APU interface
> that makes the full double precision FPU unfeasible.  The Xilinx folks
> can correct me if I'm wrong.
> =

> g.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
