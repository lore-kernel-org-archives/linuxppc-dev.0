Return-Path: <dh.herrmann@gmail.com>
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com
 [IPv6:2607:f8b0:4001:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 220E41A0021
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Sep 2014 03:28:17 +1000 (EST)
Received: by mail-ie0-f173.google.com with SMTP id lx4so6434166iec.32
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Sep 2014 10:28:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJhHMCCswNtxZvuD5XdP2vhOykRb4yhkBLbNs02SLWdFLyw0Kg@mail.gmail.com>
References: <1409369788-22563-1-git-send-email-bobby.prani@gmail.com>
 <CAMuHMdV_naTfQOLwOshWq1Q15kSE39a8GWChsjt3RrWRcd6peg@mail.gmail.com>
 <CAJhHMCDaSAzU3zvhY2FRFoBaQH4oQBTsUsYMU6pvBbCXydROZQ@mail.gmail.com>
 <CANq1E4SCnDjN5yetrgtaRNdvDr7xqGOm1BXz7dbGvX3mnsm-MA@mail.gmail.com>
 <54036090.1050104@gmail.com>
 <CANq1E4QbRLjCGr+PuHqKa6Kx_+4MTmbzd9V1RqrQFS3f5YoSag@mail.gmail.com>
 <CAJhHMCBOeLK-Z_96V_aAWBikS6tjrdYfj6_0w-9kSzQb=UJZsw@mail.gmail.com>
 <CANq1E4Sf-XMkODhxEM9Bacr_RBt8p_dHPyeyb7a70_VqrmwXeA@mail.gmail.com>
 <CAJhHMCCswNtxZvuD5XdP2vhOykRb4yhkBLbNs02SLWdFLyw0Kg@mail.gmail.com>
Date: Mon, 1 Sep 2014 19:28:15 +0200
Message-ID: <CANq1E4R+RdM2SFX1rt1M9+VYcUN6u-CTFJO0vkkscc241AnFYg@mail.gmail.com>
Subject: Re: [RFC PATCH] powerpc: Wire up three syscalls
From: David Herrmann <dh.herrmann@gmail.com>
To: Pranith Kumar <bobby.prani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: open list <linux-kernel@vger.kernel.org>, Fabian Frederick <fabf@skynet.be>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

On Mon, Sep 1, 2014 at 7:16 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> On Mon, Sep 1, 2014 at 11:31 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
>
>>
>> Btw., the original patch (wire up syscalls) can be applied unchanged.
>>
>
> Great! Can I use that as an Ack-by? I will send in the patch with
> updated changelog.

Sure, go ahead! This syscall patch is:

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David
