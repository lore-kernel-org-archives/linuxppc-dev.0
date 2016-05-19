Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9M1K0f04zDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 16:41:57 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 19 May 2016 16:41:55 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4FE7F2CE805E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 16:41:47 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4J6fYol56033298
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 16:41:42 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4J6eQCl009419
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 16:40:27 +1000
Subject: Re: [kernel-hardening] [PATCH v8 2/4] GCC plugin infrastructure
To: Michael Ellerman <mpe@ellerman.id.au>, Emese Revfy <re.emese@gmail.com>,
 kernel-hardening@lists.openwall.com
References: <20160513015456.01415979f20a68eb7d2d9290@gmail.com>
 <20160513015725.30223ee16a2a3860b4392b90@gmail.com>
 <573C2CFE.8060305@au1.ibm.com>
 <20160518123327.9018f73af78a47b4456b2027@gmail.com>
 <1463638931.10451.10.camel@ellerman.id.au>
Cc: linux-kbuild@vger.kernel.org, pageexec@freemail.hu, spender@grsecurity.net,
 mmarek@suse.com, keescook@chromium.org, linux@rasmusvillemoes.dk,
 fengguang.wu@intel.com, dvyukov@google.com,
 linux-kernel@vger.kernel.org, david.brown@linaro.org,
 yamada.masahiro@socionext.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Daniel Axtens <dja@axtens.net>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <573D5D7F.60000@au1.ibm.com>
Date: Thu, 19 May 2016 16:30:23 +1000
MIME-Version: 1.0
In-Reply-To: <1463638931.10451.10.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/05/16 16:22, Michael Ellerman wrote:
>> Did you test the plugins with all gcc versions (4.5-6)?
>
> What's the concern about gcc versions? Just not breaking the build on old
> compilers?
> I'm pretty sure powerpc big endian still builds with gcc 4.4.

gcc's plugin support only landed in 4.5, so we don't care about <=4.4.

> However if Andrew's only tested on little endian, then that select should be
> guarded with an "if CPU_LITTLE_ENDIAN". And to build LE you need gcc >= 4.9.

I'm going to give BE a test too just to be sure.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
