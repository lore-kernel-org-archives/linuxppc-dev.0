Return-Path: <axboe@kernel.dk>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
 [209.85.223.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C43AD1A09FE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 00:54:47 +1000 (AEST)
Received: by iebps5 with SMTP id ps5so7212993ieb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 07:54:45 -0700 (PDT)
Message-ID: <5579A135.1010208@kernel.dk>
Date: Thu, 11 Jun 2015 08:54:45 -0600
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Geoff Levand <geoff@infradead.org>
CC: Jim Paris <jim@jtan.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "cbe-oss-dev@lists.ozlabs.org" <cbe-oss-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] block/ps3vram: Remove obsolete reference to MTD
References: <cover.1433959045.git.geoff@infradead.org>	<c5254081722274cb11fd7d2bc4f3a91b95f0f9f6.1433959045.git.geoff@infradead.org>
 <CAMuHMdU=e=6UwQmZ0LJJhjf5DjG+Q7WsTBpm44uxeqGRqygs-Q@mail.gmail.com>
In-Reply-To: <CAMuHMdU=e=6UwQmZ0LJJhjf5DjG+Q7WsTBpm44uxeqGRqygs-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/2015 07:04 AM, Geert Uytterhoeven wrote:
> On Wed, Jun 10, 2015 at 8:00 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> did not write:
>> The ps3vram driver is a plain block device driver since commit
>> f507cd22035fdadd5dbb476dd05e9e7ee21c3b84 ("ps3/block: Replace mtd/ps3vram
>> by block/ps3vram").
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Geoff Levand <geoff@infradead.org>
>
> For the record: while I did send out this patch back in 2013, I didn't resend it
> yesterday.
>
> Geoff:
>    1. Please fix your scripts (start using git-send-email?), to avoid sending
>       fake email. Thanks!

Indeed, 2/3 of these patches ended up in my spam.

>    2. I am grateful you didn't forget about this patch, and that it got applied.

I'll add:

3. Your git base should be the base of where you want this to be pulled 
in, or prior. Yours was 4.1-rc7, and I'm not pulling in tons of 
unrelated changes for 3 patches. If you are targeting the next release 
and don't depend on existing block changes, then your base should be 
4.0. If you are dependent on changes in the block tree, the block tree 
should be your base.

-- 
Jens Axboe
