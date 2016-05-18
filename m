Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r96SJ6kk3zDq8b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 07:16:00 +1000 (AEST)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 19 May 2016 07:15:59 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5BF5C357805D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 07:15:57 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4ILFnSW1769910
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 07:15:57 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4ILFNbA015892
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 07:15:25 +1000
Subject: Re: [kernel-hardening] [PATCH v8 2/4] GCC plugin infrastructure
To: Emese Revfy <re.emese@gmail.com>, kernel-hardening@lists.openwall.com
References: <20160513015456.01415979f20a68eb7d2d9290@gmail.com>
 <20160513015725.30223ee16a2a3860b4392b90@gmail.com>
 <573C2CFE.8060305@au1.ibm.com>
 <20160518123327.9018f73af78a47b4456b2027@gmail.com>
Cc: linux-kbuild@vger.kernel.org, pageexec@freemail.hu, spender@grsecurity.net,
 mmarek@suse.com, keescook@chromium.org, linux@rasmusvillemoes.dk,
 fengguang.wu@intel.com, dvyukov@google.com,
 linux-kernel@vger.kernel.org, david.brown@linaro.org,
 yamada.masahiro@socionext.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Daniel Axtens <dja@axtens.net>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <573CDB52.30701@au1.ibm.com>
Date: Thu, 19 May 2016 07:14:58 +1000
MIME-Version: 1.0
In-Reply-To: <20160518123327.9018f73af78a47b4456b2027@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18/05/16 20:33, Emese Revfy wrote:
> Did you test the plugins with all gcc versions (4.5-6)?

No, I tested with 4.8 and 5.2 as those are the toolchains I have on hand 
- I'll try to test with the rest of 4.5 - 6.1.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
