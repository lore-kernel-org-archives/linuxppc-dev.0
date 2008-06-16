Return-Path: <bunk@kernel.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by ozlabs.org (Postfix) with ESMTP id 9DB14DDF8B
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 22:44:45 +1000 (EST)
Date: Mon, 16 Jun 2008 15:43:24 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
Message-ID: <20080616124324.GC10854@cs181133002.pp.htv.fi>
References: <18518.114.100584.607669@cargo.ozlabs.ibm.com>
	<18518.19857.917564.461743@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <18518.19857.917564.461743@cargo.ozlabs.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 16, 2008 at 09:25:05PM +1000, Paul Mackerras wrote:
> Linus,
> 
> As Ben pointed out, I had forgotten to re-do a couple of defconfigs
> where I had inadvertently turned off the SATA driver for the G5
> powermacs.  So when you do the pull as I requested earlier from
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge
> 
> you'll also get one more commit as listed below.
> 
> Thanks,
> Paul.
> 
>  arch/powerpc/configs/g5_defconfig    |   62 ++++++++++++++++++++++++++++++--
>  arch/powerpc/configs/ppc64_defconfig |   66 ++++++++++++++++++++++++++++++++--
>  2 files changed, 122 insertions(+), 6 deletions(-)
> 
> Paul Mackerras (1):
>       [POWERPC] Turn on ATA_SFF so we get SATA_SVW back in defconfigs
>...

What about my patch [1] to eliminate this new trap in kconfig since we 
do not have to bother kconfig users with ATA_SFF at all?

Besides some orthoginal discussion whether this stuff should actually be 
called SFF I am not aware of any reactions to my patch from the ATA 
people.

I already sent this patch twice and I can update it to the latest tree 
if it's considered OK, but I'd like to get some ACK/NAK first.

cu
Adrian

[1] http://lkml.org/lkml/2008/4/21/501

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
