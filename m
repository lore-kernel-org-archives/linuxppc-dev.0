Return-Path: <ppc@mindchasers.com>
Received: from qmta01.westchester.pa.mail.comcast.net
 (qmta01.westchester.pa.mail.comcast.net [IPv6:2001:558:fe14:43:76:96:62:16])
 by lists.ozlabs.org (Postfix) with ESMTP id 829F91A0204
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 02:27:41 +1000 (EST)
Message-ID: <54219D85.9090005@mindchasers.com>
Date: Tue, 23 Sep 2014 12:19:17 -0400
From: Bob Cochran <ppc@mindchasers.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, Scott Wood <scottwood@freescale.com>
Subject: Re: Pull request: scottwood/linux.git next
References: <20140922222142.GA8525@home.buserror.net>
 <5420EE93.7080006@mindchasers.com>
 <1411451106.13320.106.camel@snotra.buserror.net>
In-Reply-To: <1411451106.13320.106.camel@snotra.buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/23/2014 01:45 AM, Scott Wood wrote:
> On Mon, 2014-09-22 at 23:52 -0400, Bob Cochran wrote:
>> On 09/22/2014 06:21 PM, Scott Wood wrote:
>>> Highlights include DMA32 zone support (SATA, USB, etc now works on 64-bit
>>> FSL kernels), MSI changes, 8xx optimizations and cleanup, t104x board
>>> support, and PrPMC PCI enumeration.
>>>
>>> The following changes since commit 78eb9094ca08a40b8f9d3e113a2b88e0b7dbad1d:
>>>
>>>     powerpc/t2080rdb: Add T2080RDB board support (2014-07-31 00:11:10 -0500)
>>>
>>> are available in the git repository at:
>>>
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
>>>
>>> for you to fetch changes up to cb0446c1b625326682ec4f9d1dd10779433646bc:
>>>
>>>     Revert "powerpc/fsl_msi: spread msi ints across different MSIRs" (2014-09-19 15:20:42 -0500)
>>>
>>> ----------------------------------------------------------------
>>> Aaron Sierra (2):
>>>         fsl_ifc: Fix csor_ext position in fsl_ifc_regs
>>>         powerpc: fsl_pci: Add forced PCI Agent enumeration
>>>
>>> LEROY Christophe (7):
>>>         powerpc/8xx: Declare SPRG2 as a SCRATCH register
>>>         powerpc/8xx: Use SCRATCH0 and SCRATCH1 also for TLB handlers
>>>         powerpc/8xx: Remove loading of r10 at end of FixupDAR
>>>         powerpc/8xx: Fix comment about DIRTY update
>>>         powerpc/8xx: No need to save r10 and r3 when not calling FixupDAR
>>>         powerpc/8xx: Optimize verification in FixupDAR
>>>         powerpc/8xx: Duplicate two insns instead of branching
>>>
>>> Nikhil Badola (3):
>>>         powerpc: configs: Add VFAT file-system configs
>>>         powerpc: dts: t4240: Change T4240 USB controller version
>>>         powerpc: dts: t208x: Change T208x USB controller version
>>>
>>> Priyanka Jain (2):
>>>         powerpc/fsl-booke: Add initial T1040/T1042 RDB board support
>>
>>
>> Hi Scott,
>>
>> I would like to try your next branch with my t1040rdb along with DPAA
>> support / drivers.  I don't see DPAA support in your repo.  Can you
>> point me to a DPAA patch set somewhere, or am I on my own to merge what
>> I need from sdk or yocto?
>
> Unfortunately DPAA support has not yet been upstreamed, though it is
> being worked on.


It's great to see you confirm this.  Thank you.

Can you share a time frame on when we'll see DPAA patches start showing 
up?  I assume it will have FSL_USDPAA support stripped out?


For now if you need DPAA with the latest kernel,
> you'll need to merge it yourself based on the SDK code.  It also
> wouldn't hurt to let any sales/support contact you may have at
> Freescale know that this is important to you.
>
> -Scott
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
