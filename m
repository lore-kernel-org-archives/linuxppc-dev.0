Return-Path: <michal.simek@petalogix.com>
Message-ID: <4AF7F066.9070202@petalogix.com>
Date: Mon, 09 Nov 2009 11:35:18 +0100
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
To: microblaze-uclinux@itee.uq.edu.au
Subject: Re: [microblaze-uclinux] [PATCH 00/11] More OF merge patches
References: <20091105073728.10460.6061.stgit@angua>
In-Reply-To: <20091105073728.10460.6061.stgit@angua>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, devicetree-discuss@lists.ozlabs.org,
	sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	davem@davemloft.net
Reply-To: michal.simek@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

Grant Likely wrote:
> Round 2.  Here is my 2nd set of merging OF code between PowerPC and
> Microblaze (no SPARC changes this time).  Compile tested on ppc,
> microblaze and sparc.  Boot tested on MPC5200 powerpc platform.

I tested your test-device-tree branch - boot tested on ml505 for MMU and 
noMMU kernels.
I expect that you will add these patches to next branch. I test it every 
day - if is any problem with Microblaze, I will let you know.

Tested-by: Michal Simek <monstr@monstr.eu>

Thanks for this work,
Michal

> 
> I've also pushed this series out to the test-devicetree branch on my
> git server if anyone cares to pull and test:
> 
> git://git.secretlab.ca/git/linux-2.6 test-devicetree
> 
> This is based on the next-devicetree branch which contains the first
> round of patches and is being pulled into linux-next.
> 
> Cheers,
> g.
> 
> ---
> 
> Grant Likely (11):
>       of/flattree: Merge early_init_dt_check_for_initrd()
>       of: remove special case definition of of_read_ulong()
>       of: merge prom_{add,remove,modify}_property
>       of/flattree: Merge unflatten_device_tree
>       of/flattree: Merge unflatten_dt_node
>       of/flattree: Merge of_flat_dt_is_compatible
>       of/flattree: merge of_get_flat_dt_prop
>       of/flattree: remove __init annotations from the header file
>       of/flattree: merge of_get_flat_dt_root
>       of/flattree: merge of_scan_flat_dt
>       of/flattree: merge find_flat_dt_string and initial_boot_params
> 
> 
>  arch/microblaze/Kconfig            |    1 
>  arch/microblaze/include/asm/prom.h |    1 
>  arch/microblaze/kernel/prom.c      |  531 ------------------------------------
>  arch/powerpc/Kconfig               |    1 
>  arch/powerpc/kernel/prom.c         |  534 ------------------------------------
>  drivers/of/Kconfig                 |    4 
>  drivers/of/Makefile                |    1 
>  drivers/of/base.c                  |  116 ++++++++
>  drivers/of/fdt.c                   |  458 +++++++++++++++++++++++++++++++
>  include/linux/of.h                 |   10 -
>  include/linux/of_fdt.h             |   21 +
>  11 files changed, 598 insertions(+), 1080 deletions(-)
>  create mode 100644 drivers/of/fdt.c
> 
> ___________________________
> microblaze-uclinux mailing list
> microblaze-uclinux@itee.uq.edu.au
> Project Home Page : http://www.itee.uq.edu.au/~jwilliams/mblaze-uclinux
> Mailing List Archive : http://www.itee.uq.edu.au/~listarch/microblaze-uclinux/
> 


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
