Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id C6A15DE06B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 00:41:45 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so96013anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 07:41:43 -0700 (PDT)
Date: Mon, 29 Sep 2008 10:40:27 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'dma' branch
Message-ID: <20080929144027.GA3866@yoda.jdub.homelinux.org>
References: <Pine.LNX.4.64.0809241652540.22678@blarg.am.freescale.net>
	<295973D9-5AD2-47A3-B858-CED501169D86@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <295973D9-5AD2-47A3-B858-CED501169D86@kernel.crashing.org>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 29, 2008 at 08:12:11AM -0500, Kumar Gala wrote:
>
> On Sep 24, 2008, at 4:54 PM, Kumar Gala wrote:
>
>> Please pull from 'dma' branch of
>>
>> (forgot linuxppc-dev on first go around)
>>
>> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git dma
>>
>> to receive the following updates:
>>
>> arch/powerpc/include/asm/device.h       |    3
>> arch/powerpc/include/asm/dma-mapping.h  |  187 ++++++++ 
>> +--------------------
>> arch/powerpc/include/asm/machdep.h      |    5
>> arch/powerpc/include/asm/pci.h          |   14 +-
>> arch/powerpc/include/asm/types.h        |    2
>> arch/powerpc/kernel/Makefile            |    4
>> arch/powerpc/kernel/dma-iommu.c         |  103 ++++++++++++++++
>> arch/powerpc/kernel/dma.c               |  127 ++++++++++++++++++++
>> arch/powerpc/kernel/dma_64.c            |  200  
>> --------------------------------
>> arch/powerpc/kernel/of_device.c         |    2
>> arch/powerpc/kernel/pci-common.c        |   48 +++++++
>> arch/powerpc/kernel/pci_32.c            |    7 +
>> arch/powerpc/kernel/pci_64.c            |   49 -------
>> arch/powerpc/kernel/vio.c               |    2
>> arch/powerpc/platforms/cell/iommu.c     |    6
>> arch/powerpc/platforms/ps3/system-bus.c |    2
>> 16 files changed, 366 insertions(+), 395 deletions(-)
>>
>> Becky Bruce (5):
>>      powerpc: Rename dma_64.c to dma.c
>>      powerpc: Move iommu dma ops from dma.c to dma-iommu.c
>>      powerpc: Drop archdata numa_node
>>      powerpc: Merge 32 and 64-bit dma code
>>      powerpc: Make dma_addr_t a u64 if CONFIG_PHYS_64BIT is set
>
> Paul,
>
> poke..

Vacation for a week.  I guess we're supposed to poke benh now.  Or wait a week.

josh
