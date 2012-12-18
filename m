Return-Path: <linus971@gmail.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 04C972C007B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2012 05:02:35 +1100 (EST)
Received: by mail-wi0-f177.google.com with SMTP id hm2so604080wib.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2012 10:02:31 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1355787094.5397.30.camel@pasglop>
References: <1355517897.19932.136.camel@pasglop>
 <1355787094.5397.30.camel@pasglop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 18 Dec 2012 10:02:11 -0800
Message-ID: <CA+55aFw-cRskrvW07FVJd9HfrBhn41Ogi1Vv_v1U12zahzFu=A@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git next branch
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 17, 2012 at 3:31 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2012-12-15 at 07:44 +1100, Benjamin Herrenschmidt wrote:
>> Hi Linus !
>>
>> Finally managed to get my head away from some other distractions
>> to put this pull request together, sorry for the lateness :-)
>>
>> The main highlight is probably some base POWER8 support. There's
>> more to come such as transactional memory support but that will
>> wait for the next one. (next merge window)
>>
>> Overall it's pretty quiet, or rather I've been pretty poor at
>> picking things up from patchwork and reviewing them this time
>> around and Kumar no better on the FSL side it seems...
>
> So it looks like I'm an idiot and totally failed to put your email
> address on the CC list of that pull request :-)

.. yeah, that helps.

Anyway, I've pulled it in, but got a conflict on the kernel_thread
cleanups from Al. And since the conflict was in the powerpc assembly
code that I don't really know the details of, I did the
straightforward resolve of it, but I'd like you to check it out.

(I haven't pushed it out yet, I'm waiting for the allmodconfig to
finish compiling, so if you see this email quickly, but don't see the
powerpc merge yet, just wait a few minutes)

                Linus
