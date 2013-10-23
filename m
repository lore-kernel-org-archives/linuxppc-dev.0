Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0ED652C0647
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 20:28:22 +1100 (EST)
Message-ID: <526796AC.9000207@windriver.com>
Date: Wed, 23 Oct 2013 17:28:12 +0800
From: =?UTF-8?B?IuKAnHRpZWp1bi5jaGVu4oCdIg==?= <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v5][PATCH 6/6] book3e/kgdb: Fix a single stgep case of lazy IRQ
References: <1371724110-8250-1-git-send-email-tiejun.chen@windriver.com>	
 <1371724110-8250-7-git-send-email-tiejun.chen@windriver.com>
 <1382139147.7979.934.camel@snotra.buserror.net>
In-Reply-To: <1382139147.7979.934.camel@snotra.buserror.net>
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

On 10/19/2013 07:32 AM, Scott Wood wrote:
> On Thu, 2013-06-20 at 18:28 +0800, Tiejun Chen wrote:
>> When we're in kgdb_singlestep(), we have to work around to get
>> thread_info by copying from the kernel stack before calling
>> kgdb_handle_exception(), then copying it back afterwards.
>>
>> But for PPC64, we have a lazy interrupt implementation. So after
>> copying thread info frome kernle stack, if we need to replay an
>> interrupt, we shouldn't restore that previous backup thread info
>> to make sure we can replay an interrupt lately with a proper
>> thread info.
>
> Explain why copying it would be a problem.
>

This would be gone away in next version as well :)

Thanks,

Tiejun
