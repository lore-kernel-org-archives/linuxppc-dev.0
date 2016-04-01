Return-Path: <linus.walleij@linaro.org>
Received: from mail-oi0-x22d.google.com (mail-oi0-x22d.google.com
 [IPv6:2607:f8b0:4003:c06::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbvB65cr4zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 19:07:26 +1100 (AEDT)
Received: by mail-oi0-x22d.google.com with SMTP id o62so95327766oig.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Apr 2016 01:07:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1459477889.10334.1.camel@ellerman.id.au>
References: <1459408452-3483-1-git-send-email-linus.walleij@linaro.org>
 <1459418980.24848.1.camel@ellerman.id.au>
 <CACRpkdbbUfbe6LWVDFsgvne7oOEp7ZzOKr9tX7y-P=J8g7c5=A@mail.gmail.com>
 <1459477889.10334.1.camel@ellerman.id.au>
Date: Fri, 1 Apr 2016 10:07:23 +0200
Message-ID: <CACRpkdZOOQ5pP8GtN1WP-y-Es+5mKuBOhRtFyUNO1Qesyb+Z8g@mail.gmail.com>
Subject: Re: [PATCH] powerpc: ppc4xx: drop unused variable
From: Linus Walleij <linus.walleij@linaro.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Anatolij Gustschin <agust@denx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 1, 2016 at 4:31 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Thu, 2016-03-31 at 14:57 +0200, Linus Walleij wrote:
>> On Thu, Mar 31, 2016 at 12:09 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> > If you feel like cross building powerpc in future it should be as simple as:
>> >
>> >  $ dnf install gcc-powerpc64-linux-gnu || apt-get install gcc-powerpc-linux-gnu
>> >  $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- ...
>>
>> Ah hm yeah I guess everyone "should", it's just that these days I
>> mainly rely on Fenguang's kautobuild to do this job for me and
>> get back with the result from a plethora of arches.
>
> Sure. That makes sense for all the silly little architectures.
>
> But for powerpc you should really cross compile.

I think kautobuild cross compiles?

The only thing that happens IIUC is I let somebody else do the
job at the Intel server farm.

Yours,
Linus Walleij
