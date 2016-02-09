Return-Path: <dave.long@linaro.org>
Received: from mail-qg0-x230.google.com (mail-qg0-x230.google.com
 [IPv6:2607:f8b0:400d:c04::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F0351A038E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 07:53:44 +1100 (AEDT)
Received: by mail-qg0-x230.google.com with SMTP id y89so75874345qge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Feb 2016 12:53:44 -0800 (PST)
Subject: Re: [PATCH v3 0/2] Consolidate redundant register/stack access code
To: Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>
References: <1454996337-7935-1-git-send-email-dave.long@linaro.org>
 <1455010600.13384.3.camel@ellerman.id.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
 "chengang@emindsoft.com.cn" <chengang@emindsoft.com.cn>,
 Andy Lutomirski <luto@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>,
 David Hildenbrand <dahi@linux.vnet.ibm.com>,
 Denys Vlasenko <dvlasenk@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Oleg Nesterov
 <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Rashmica Gupta <rashmicy@gmail.com>, Rich Felker <dalias@libc.org>,
 Richard Kuo <rkuo@codeaurora.org>, Roland McGrath <roland@hack.frob.com>,
 Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
From: David Long <dave.long@linaro.org>
Message-ID: <56BA51D3.9030204@linaro.org>
Date: Tue, 9 Feb 2016 15:53:39 -0500
MIME-Version: 1.0
In-Reply-To: <1455010600.13384.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/09/2016 04:36 AM, Michael Ellerman wrote:
> On Tue, 2016-02-09 at 00:38 -0500, David Long wrote:
>
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Move duplicate and functionally equivalent code for accessing registers
>> and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
>> common kernel files.
>>
>> I'm sending this out again (with updated distribution list) because v2
>> just never got pulled in, even though I don't think there were any
>> outstanding issues.
>
> A big cross arch patch like this would often get taken by Andrew Morton, but
> AFAICS you didn't CC him - so I just added him, perhaps he'll pick it up for
> us :D
>
> cheers
>

Thanks much.

-dl
