Return-Path: <bobby.prani@gmail.com>
Received: from mail-vc0-x234.google.com (mail-vc0-x234.google.com
 [IPv6:2607:f8b0:400c:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 200DB1A06F5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 00:31:08 +1100 (AEDT)
Received: by mail-vc0-f180.google.com with SMTP id hq12so12085711vcb.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 06:31:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1426493810.4716.0.camel@ellerman.id.au>
References: <CAJhHMCC+BJWBo3=XbLf2L_kpOTqR==ee667+TpnFdk3DRT3o+Q@mail.gmail.com>
 <CAJhHMCBcyVbNRQSpsyVfk8HMzZ=NXKkknjDRuch+e+yJGB3T5Q@mail.gmail.com>
 <1426493810.4716.0.camel@ellerman.id.au>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 16 Mar 2015 09:30:34 -0400
Message-ID: <CAJhHMCC06H-BRFBBcD_PfumyvHoFAjbi_MOn7gSeq5y093FSEQ@mail.gmail.com>
Subject: Re: linux panic on 4.0.0-rc4
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 16, 2015 at 4:16 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Mon, 2015-03-16 at 01:34 -0400, Pranith Kumar wrote:
>> On Mon, Mar 16, 2015 at 1:11 AM, Pranith Kumar <bobby.prani@gmail.com> wrote:
>> > Hello,
>> >
>> > I have a power mac mini 32-bit system.
>> >
>> ...
>> > You can see the panic message here: http://imgur.com/s1lH15g. (there
>> > is no log and I have no serial console).
>>
>> There was some debug code in there when it hit. The actual hang seems
>> to be in printk_late_init(). It does not return from this. May be this
>> is a hint?
>
> That is where the boot consoles get disabled and it switches to the "real"
> console. It suggests that the system is not "hung" there but you just lost
> output.
>
> Try booting with "keep_bootcon" ?

I tried this and got to the same place as in the first mail:
http://imgur.com/s1lH15g

There is a kernel panic with the message printed. Any more suggestions
to how to debug this?

-- 
Pranith
