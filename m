Return-Path: <joseph.salisbury@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) by ozlabs.org (Postfix) with ESMTP id 760D414008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 04:00:54 +1000 (EST)
Message-ID: <534EC54C.9080705@canonical.com>
Date: Wed, 16 Apr 2014 14:00:44 -0400
From: Joseph Salisbury <joseph.salisbury@canonical.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1] powerpc: Increase COMMAND_LINE_SIZE to 2048 from 512.
References: <cover.1397260361.git.joseph.salisbury@canonical.com>	
 <84356b1cb9452226d54641a71e4b1363e78d4417.1397260362.git.joseph.salisbury@canonical.com>	
 <534C2FEB.2000803@canonical.com> <1397555363.14218.6.camel@pasglop>
In-Reply-To: <1397555363.14218.6.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/15/2014 05:49 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2014-04-14 at 14:58 -0400, Joseph Salisbury wrote:
>> After further review, it appears ppc does not actually use the define
>> in
>> the ppc headers but uses the common generic
>> default(include/uapi/asm-generic/setup.h).  COMMAND_LINE_SIZE should
>> probably become a kernel config option.  Do folks agree that is the
>> correct thing to do?  If so, I can re-work the patch.
> No objection on my side.
>
> Make sure you remove any unused arch define while at it.
>
> Cheers,
> Ben.
>
>
Hi Ben,

I can think of two ways to add the new config option.  One would be to
have a large entry in ~/arch/Kconfig, with a default COMMAND_LINE_SIZE
line for each architecture.  The other way would be to have the default
value for COMMAND_LINE_SIZE in the architecture sub-directory Kconfig
file: ~/arch/powerpc/Kconfig for example.

Do you have a preference for either way?

Thanks,

Joe
