Return-Path: <dbaryshkov@gmail.com>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
 [209.85.210.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EF39BB702A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 02:18:29 +1000 (EST)
Received: by dang27 with SMTP id g27so6281088dan.15
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Apr 2012 09:18:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1332222008.2982.13.camel@pasglop>
References: <CALT56yO05UBY6=KqK94=_sC4hd3ranj5J5CXOAo5hSjVAdkgkA@mail.gmail.com>
 <1332031585.3105.197.camel@pasglop>
 <CALT56yOaxfWYwxvBDbo9dpWo9y37dO0iGge4x6kciZp1oXXHVw@mail.gmail.com>
 <1332103797.3105.202.camel@pasglop>
 <CALT56yPjkPQOaXW4Eg8c-S4+a4Omou_YYacqrsCoTAYeXO0XkA@mail.gmail.com>
 <1332222008.2982.13.camel@pasglop>
Date: Mon, 9 Apr 2012 20:18:26 +0400
Message-ID: <CALT56yOU2FDTNRnr=aLVFTGHiVsGNKVoqLqAWQ7Q+Xzg6_B8qQ@mail.gmail.com>
Subject: Re: Problem with framebuffer mmap on platforms with large addressing
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev@vger.kernel.org,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Tony Breeds <tbreeds@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2012 at 9:40 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
>> >> That is interesting! Are those patches published or otherwise available
>> >> somewhere? We are also very interested in enabling Canyonlands
>> >> with Radeon KMS!
>> >
>> > You will run into additional problems with 460 due to the fact that it's
>> > not cache coherent for DMA. Tony patches don't address that part of the
>> > problem (they were used on a 476 based platform).
>>
>> Hmm. Could you please spill a little bit more of details? Also are those patches
>> for 476 merged or present somewhere?
>
> Well, DMA on 46x isn't cache coherent. The DRM plays interesting games
> with mapping/unmapping pages for DMA by the chip and I don't think we
> have the right hooks to do the appropriate cache flushing on these guys,
> but Tony might be able to comment, I don't know whether he tried or not.
>
> On the other hand 476 has fully cache coherent DMA so the only problem
> there is the >32-bit physical address space.
>
> As for the patches, you'll have to wait for Tony to respond (I'll poke
> him locally).

Any news on these patches? A dirty and "not for the upstream yet" version
would be sufficient for me for now.

>
> Cheers,
> Ben.
>

-- 
With best wishes
Dmitry
