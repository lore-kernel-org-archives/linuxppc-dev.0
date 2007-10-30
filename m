Return-Path: <rwoodworth@securics.com>
Received: from securics.com (unknown [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id F2DD8DE434
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Oct 2007 04:14:23 +1100 (EST)
Subject: Re: videobuf
From: Robert Woodworth <rwoodworth@securics.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40710300919y4f231eb4w4ba4bc0c8d9260ff@mail.gmail.com>
References: <1193758138.4606.7.camel@PisteOff>
	<fa686aa40710300919y4f231eb4w4ba4bc0c8d9260ff@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 30 Oct 2007 11:14:22 -0600
Message-Id: <1193764462.4636.3.camel@PisteOff>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

That does work and nothing seams to be broken just yet.
I also removed the dependency from the vivi (virtual video) module and
that modules works fine.




However, I tried to enable PCI support and that failed with undefined
PCI addresses.  (duh. I have no PCI on the board)



RJW.




On Tue, 2007-10-30 at 10:19 -0600, Grant Likely wrote:
> On 10/30/07, Robert Woodworth <rwoodworth@securics.com> wrote:
> > I'm  working on building a v4l2 driver for an FPGA module on a Xilinx
> > Virtex4 PPC.
> >
> > Question:
> > Why does the v4l2 videobuf *depend* on PCI?
> 
> You could try dropping the dependency from Kconfig and see what breaks
> when you compile the core v4l2 stuff.
> 
> Cheers,
> g.
> 
