Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews05.kpnxchange.com (cpsmtpb-ews05.kpnxchange.com
 [213.75.39.8])
 by lists.ozlabs.org (Postfix) with ESMTP id 26A021A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 20:06:42 +1000 (EST)
Message-ID: <1400839597.31526.21.camel@x220>
Subject: Re: powerpc: remove checks for CONFIG_BOOK3E_MMU_TLB_STATS
From: Paul Bolle <pebolle@tiscali.nl>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 23 May 2014 12:06:37 +0200
In-Reply-To: <1400830406.31526.6.camel@x220>
References: <1400608550.4912.48.camel@x220>
 <20140522223758.GA20343@home.buserror.net> <1400830406.31526.6.camel@x220>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-23 at 09:33 +0200, Paul Bolle wrote:
> Scott,
> 
> On Thu, 2014-05-22 at 17:37 -0500, Scott Wood wrote:
> > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S: Assembler messages:
> > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:89: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:238: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:269: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:281: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:441: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:510: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:881: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> > /home/scott/fsl/git/linux/upstream/arch/powerpc/mm/tlb_low_64e.S:918: Error: unrecognized opcode: `tlb_miss_prolog_stats'
> 
> Thanks for testing!
> 
> That's a bit surprising. The patch is intended to be a non event. Ie, it
> only removes what the preprocessor would have removed anyway. Unless I
> botched it, of course.
> 
> What exactly did you test there?

For what it's worth: I can't reproduce this error with the cross
compiler now shipped with Fedora 20 (ie, powerpc64-linux-gnu-gcc (GCC)
4.8.1 20130717 (Red Hat 4.8.1-5)). It shows a nice and clean
     AS      arch/powerpc/mm/tlb_low_64e.o

in the output.

That's v3.15-rc6, with just this patch, and using a .config generated,
with "make oldconfig", from arch/powerpc/configs/ppc64e_defconfig.


Paul Bolle
