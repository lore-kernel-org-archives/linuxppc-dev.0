Message-ID: <3812E624.BF756DFF@263.net>
Date: Sun, 24 Oct 1999 18:57:40 +0800
From: Wang Yong <wung_y@263.net>
Reply-To: wung_y@263.net
MIME-Version: 1.0
To: Grant Erickson <grant@lcse.umn.edu>
CC: linuxppc embedded mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: TiVo Kernel for 403GCX Update (was Re: Support for IBM CPUs?)
References: <Pine.SGI.4.10.9910222012050.46619-100000@brule.lcse.umn.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
  It appears you compiled this kernel with GCC, so i am wondering if
GCC could work correctly with some architecture specified instructions
of
PPC embedded controller? Do you know if GCC could compile the kernel
written
for 401D2, another embedded controller from IBM? this is very important
for
us because we're starting to port linux to this platform(RedWood3) but
we still don't know which compiler should be ok.

Regards,
Wang


Grant Erickson wrote:
> 
> I've made some progress since Wednesday with the TiVo source code. As I
> mentioned previously, the TiVo Linux kernel is based on the 2.1.24 PowerPC
> sources. However, after comparing the tree against both stock 2.1.24 and
> 2.2.12 trees, it appears they've borrowed code from more recent trees and
> HEAVILY modified the 2.1.24 code in others.
> 
> They have configurations for both the TeleWorld Consumer Device (TCD) and
> the TeleWorld Consumer Device Eval Board (TCD_EVAL). The latter of these
> is presumed to be the IBM PowerPC 403GCX "Oak" evaluation board.
> 
> Included in arch/ppc are two configuration files, devconf and prodconf,
> one presumably for development/manufacturing configurations and the other
> for released product in the field (I've included devconf below).
> 
> Compiling this with the LATEST released set of GNU tools and the GCC
> 2.95.1 compiler was pretty straightforward using the 'devconf'
> configuration as a base and then adding "CONFIG_TCD_EVAL=y" for my IBM
> evaluation board.
> 
> The only major changes required were to drivers/char/serial.c (which is
> changed dramatically from stock) and arch/ppc/tcd/qdma.c (a DMA engine for
> their Audio, Video, and disk controllers).
> 
> Anyway, I was able to successfully load the kernel to the IBM evaluation
> board using the tftpboot functionality in the IBM-supplied PROM; however,
> the system froze after a few instructions.
> 
> Time to hook up the ICE and figure out where things are stopping...
> 
> Getting most of the changes into the 2.3.x development tree shouldn't be
> too difficult. I've got some preliminary stuff done. What is the best
> protocol to follow, submit the patches to the list for general evaluation
> and dissemination or send them to Cort and then everyone call grab them
> from vger?
> 
> Anyone else out there call up TiVo and get their source code yet?
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
