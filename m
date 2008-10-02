Return-Path: <bigeasy@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C418DDDF90
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 23:03:33 +1000 (EST)
Message-ID: <48E4C697.30105@linutronix.de>
Date: Thu, 02 Oct 2008 15:03:19 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: dtb and purgatory support for ppc32
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
	<1222896024-22172-4-git-send-email-sebastian@breakpoint.cc>
	<2AF4947A-B0E5-4530-9240-55C94A73E9FC@kernel.crashing.org>
In-Reply-To: <2AF4947A-B0E5-4530-9240-55C94A73E9FC@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Oct 1, 2008, at 4:20 PM, Sebastian Andrzej Siewior wrote:
> 
>> From: Sebastian Siewior <bigeasy@linutronix.de>
>>
>> Some code dtb scanning & filling has been borrowed from ppc64.
>> The old behavior is still available if compiled with GameCube,
>> other PowerPC platform use the can purgatory and specify a new
>> dtb.
>> The purgatory is disabled because somehting is wrong and I dunno
>> the reason. Booting a self containd cuImage (incl. dtb / wiuthout
>> the need for a bd sturct) can be booted.
>>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>> kexec/arch/ppc/Makefile            |    1 +
>> kexec/arch/ppc/kexec-elf-ppc.c     |  167 ++++++++++----
>> kexec/arch/ppc/kexec-elf-rel-ppc.c |    4 +
>> kexec/arch/ppc/kexec-ppc.c         |  469 
>> +++++++++++++++++++++++++++++++++++-
>> purgatory/arch/ppc/Makefile        |    1 +
>> purgatory/arch/ppc/purgatory-ppc.c |    4 +
>> purgatory/arch/ppc/v2wrap.S        |   54 ++++
>> 7 files changed, 652 insertions(+), 48 deletions(-)
>> create mode 100644 purgatory/arch/ppc/v2wrap.S
> 
> I think I might have realized some of my confusion.. is this patch to 
> the kernel or to some kexec tool?   If its to the kernel I don't answer 
> at all.  If its to some kexec tool than that wasn't clear at all.

Patch 1 and 2 were for kernel side support. Patch 3 is kexec userland 
only. I wrote this down in the patch first email (should be 0/3) but now I 
see that git did not enumerate them. Sorry for that, I see that I have to 
work on git skills....

The two patches tagged with [RFC] is kernel side support. The third patch 
tagged with [PATCH] is also meant to be [RFC] and is the kexec userland 
part against [1].


[1] git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools.git

> - k

Sebastian
