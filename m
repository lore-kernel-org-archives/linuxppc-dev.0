Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	by ozlabs.org (Postfix) with ESMTP id CCC10DDEDB
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 08:09:44 +1000 (EST)
From: Rob Landley <rob@landley.net>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] qemu platform, v2
Date: Wed, 17 Oct 2007 18:09:28 -0500
References: <boot-8-00.miltonm@bga.com>
	<20071001053326.GA15132@localhost.localdomain>
	<fa686aa40710171328y195aca9k6ee8a1a5502fcf57@mail.gmail.com>
In-Reply-To: <fa686aa40710171328y195aca9k6ee8a1a5502fcf57@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710171809.28922.rob@landley.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 17 October 2007 3:28:41 pm Grant Likely wrote:
> > Including .dtbs in the kernel tree has a big practical problem:
> > they're binary, so can't be patch(1)ed, which makes updating them a
> > complete PITA.

I note that kconfig includes the lex/yacc output files (blah.c_shipped) so you 
don't have to have lex and yacc installed to run "menuconfig".  It _also_ 
includes the lex/yacc source which is what you patch and rebuild the _shipped 
files from when they need to be changed.

> > I'm working on merging dtc into the kernel tree instead.
>
> I'm kind of late to this party; but I have to say I disagree.  Most of
> us are doing just fine installing the dtc tool (and mkimage tool for
> that matter).  Cloning it in the kernel tree is just asking for
> divergence.

Milton Miller has some patches that make a "PPC qemu target" kernel image 
which doesn't include a device tree, and generates a rom image to boot qemu 
with which contains a device tree and hands it off to the Linux kernel.  If 
qemu can merge that rom image in its BIOS collection, this approach would 
meet my immediate needs.

> Cheers,
> g.

Rob
-- 
"One of my most productive days was throwing away 1000 lines of code."
  - Ken Thompson.
