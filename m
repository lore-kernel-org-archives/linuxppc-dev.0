Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59EF8DDFDD
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 04:42:27 +1000 (EST)
Message-Id: <5FCD7AA1-1A27-46C4-99E0-6C37BB21DD31@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <49F064EB.5030109@gefanuc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/86xx: clean up smp init code
Date: Thu, 23 Apr 2009 13:42:17 -0500
References: <1240421691-10193-1-git-send-email-galak@kernel.crashing.org>
	<49F064EB.5030109@gefanuc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 23, 2009, at 7:54 AM, Martyn Welch wrote:

> Kumar Gala wrote:
>> Removed the need for asm/mpc86xx.h as it was only used in  
>> mpc86xx_smp.c
>> and just moved the defines it cared about into there.  Also fixed up
>> the ioremap to only map the one 4k page we need access to and to  
>> iounmap
>> when we are done.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> arch/powerpc/include/asm/mpc86xx.h         |   33  
>> ----------------------------
>> arch/powerpc/platforms/86xx/gef_ppc9a.c    |    1 -
>> arch/powerpc/platforms/86xx/gef_sbc310.c   |    1 -
>> arch/powerpc/platforms/86xx/gef_sbc610.c   |    1 -
>> arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    1 -
>> arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    1 -
>> arch/powerpc/platforms/86xx/mpc86xx_smp.c  |    8 ++++++-
>> arch/powerpc/platforms/86xx/sbc8641d.c     |    1 -
>> 8 files changed, 7 insertions(+), 40 deletions(-)
>> delete mode 100644 arch/powerpc/include/asm/mpc86xx.h
>>
>>
> I assume this patch relies on one of the other patches posted?
>
> Just applying this patch to my development tree (based on your main  
> branch) resulted in the following on a PPC9A:

Darn, this should have been a simple change.  I'll try it out on  
mpc8641 to see if its happening there.

- k
