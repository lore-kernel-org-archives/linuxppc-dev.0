Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20051028103041.B15268@cox.net>
References: <17250.8725.358204.62510@cargo.ozlabs.ibm.com>
	<20051028103041.B15268@cox.net>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E053D1B7-2363-45D1-AEFC-83B8B5B4C4F8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 28 Oct 2005 13:44:36 -0500
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, ppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: Patches for 2.6.15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 28, 2005, at 12:30 PM, Matt Porter wrote:

> On Fri, Oct 28, 2005 at 11:05:25PM +1000, Paul Mackerras wrote:
>
>> If anyone has patches for arch/ppc{,64} and include/asm-ppc{,64} that
>> they would like to see go upstream now that 2.6.14 is out, other than
>> patches that are already in the powerpc-merge tree, please let me
>> know.  I am planning to ask Linus to pull the powerpc-merge tree
>> shortly, and that will probably break your patches.
>>
>
> Ok, we have a set of 4xx patches that I plan to send to Andrew.
> They are some existing 4xx SoC/board updates as well as a new
> SoC/board. They are obviously mostly confined to the 4xx code paths
> but there's likely conflicts in changes to Makefiles, etc.
>
> Would you prefer these going upstream before or after the
> powerpc-merge pull?

Can we ask Andrew to flush any ppc patches in -mm to linus before we  
have Linus pull the merge tree.

The following are patches that should probably go to linus before the  
merge tree that exist in 2.6.14-rc5-mm1:

(I may have missed some, but these where the obvious ones)

+ppc32-85xx-phy-platform-update.patch
+ppc32-ppc_sys-fixes-for-8xx-and-82xx.patch

  ppc32 updates

+various-powerpc-32bit-ppc64-build-fixes.patch
+ppc64-reenable-make-install-with-defconfig.patch
+ppc64-change-name-of-target-file-during-make-install.patch
+ppc64-remove-duplicate-local-variable-in-set_preferred_console.patch

- kumar
