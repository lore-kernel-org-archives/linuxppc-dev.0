Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHLdX5TsnzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 22:46:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>, Paul Mackerras <paulus@ozlabs.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings
In-Reply-To: <20170502211701.6e84c10e@canb.auug.org.au>
References: <20170502160530.34b680b7@canb.auug.org.au>
 <878tmfega2.fsf@concordia.ellerman.id.au>
 <20170502211701.6e84c10e@canb.auug.org.au>
Date: Tue, 02 May 2017 22:46:31 +1000
Message-ID: <87wp9zifyw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> On Tue, 02 May 2017 19:53:25 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Though we are supposed to be building with -Werror, so those should be
>> breaking the build. I assume you have turned Werror off?
>
> I assume that allyesconfig turns on CONFIG_PPC_DISABLE_WERROR ...

Yep. Sorry you did mention it was allyesconfig in your original mail, zzzz!

cheers
