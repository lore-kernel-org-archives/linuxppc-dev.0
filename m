Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EDF292C00FB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2012 20:14:24 +1100 (EST)
Message-ID: <50D2D6E6.2080609@windriver.com>
Date: Thu, 20 Dec 2012 17:14:14 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/book3e: load critical/machine/debug exception
 stack
References: <1351147410-17452-1-git-send-email-tiejun.chen@windriver.com>
 <6AE080B68D46FC4BA2D2769E68D765B7081D305D@039-SN2MPN1-023.039d.mgd.msft.net>
In-Reply-To: <6AE080B68D46FC4BA2D2769E68D765B7081D305D@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jason.wessel@windriver.com" <jason.wessel@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/19/2012 06:10 AM, Tabi Timur-B04825 wrote:
> On Thu, Oct 25, 2012 at 1:43 AM, Tiejun Chen <tiejun.chen@windriver.com> wrote:
>> We always alloc critical/machine/debug check exceptions. This is
>> different from the normal exception. So we should load these exception
>> stack properly like we did for booke.
>
> Tiejun,
>
> I'm a little confused by these patches, because the actual critical
> exception handlers are still commented out:
>
> /* Critical Input Interrupt */
> 	START_EXCEPTION(critical_input);
> 	CRIT_EXCEPTION_PROLOG(0x100, BOOKE_INTERRUPT_CRITICAL,
> 			      PROLOG_ADDITION_NONE)
> //	EXCEPTION_COMMON(0x100, PACA_EXCRIT, INTS_DISABLE)
> //	bl	special_reg_save_crit
> //	CHECK_NAPPING();
> //	addi	r3,r1,STACK_FRAME_OVERHEAD
> //	bl	.critical_exception
> //	b	ret_from_crit_except
> 	b	.
>
> Are you working on fixing this?  I'm trying to fix it, too, but I

No, I have no approach to Crit/MC and currently I'm focus only on Debug so 
please do this as you expect :)

BTW, I send next version just now since there are something needed to 
correct/improve.

Tiejun
