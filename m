Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 574AD2C0403
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 20:27:33 +1100 (EST)
Message-ID: <5267967A.6010707@windriver.com>
Date: Wed, 23 Oct 2013 17:27:22 +0800
From: =?UTF-8?B?IuKAnHRpZWp1bi5jaGVu4oCdIg==?= <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v5][PATCH 3/6] book3e/kgdb: update thread's dbcr0
References: <1371724110-8250-1-git-send-email-tiejun.chen@windriver.com>	
 <1371724110-8250-4-git-send-email-tiejun.chen@windriver.com>
 <1382137030.7979.914.camel@snotra.buserror.net>
In-Reply-To: <1382137030.7979.914.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/19/2013 06:57 AM, Scott Wood wrote:
> On Thu, 2013-06-20 at 18:28 +0800, Tiejun Chen wrote:
>> gdb always need to generate a single step properly to invoke
>> a kgdb state. But with lazy interrupt, book3e can't always
>> trigger a debug exception with a single step since the current
>> is blocked for handling those pending exception, then we miss
>> that expected dbcr configuration at last to generate a debug
>> exception.
>
> What do you mean by "the current is blocked"?  Could you explain more
> clearly what lazy EE has to do with MSR_DE and DBCR0?
>

I will go another path to make sure the lazy EE doesn't affect KGDB, so please 
see next version.

Thanks,

Tiejun
