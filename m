Date: Thu, 24 Apr 2003 13:32:22 -0400
From: Kent Borg <kentborg@borg.org>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: boot/simple in ROM?
Message-ID: <20030424133222.B8490@borg.org>
References: <20030424123313.A8490@borg.org> <3EA81B3F.9080709@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3EA81B3F.9080709@embeddededge.com>; from dan@embeddededge.com on Thu, Apr 24, 2003 at 01:13:35PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 24, 2003 at 01:13:35PM -0400, Dan Malek wrote:
> The other really nice thing about these bootloaders, compressed
> kernels, and attached initrd, is you can boot the identical image
> from all "devices."  For example, during development you can tftp
> load the image, get everything working, then place the exact same
> bits into a flash rom.  Simply jump to the first location of the
> image and it will boot from flash.

Yes, but disappointingly the ppc/boot/simple I am using (from 2.4
devel) won't run from ROM.  Is there a better boot loader I should be
using?

Thanks,

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
