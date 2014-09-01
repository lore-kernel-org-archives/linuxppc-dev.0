Return-Path: <bobby.prani@gmail.com>
Received: from mail-la0-x236.google.com (mail-la0-x236.google.com
 [IPv6:2a00:1450:4010:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E9DA1A000C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Sep 2014 03:17:09 +1000 (EST)
Received: by mail-la0-f54.google.com with SMTP id b17so6303073lan.41
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Sep 2014 10:17:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANq1E4Sf-XMkODhxEM9Bacr_RBt8p_dHPyeyb7a70_VqrmwXeA@mail.gmail.com>
References: <1409369788-22563-1-git-send-email-bobby.prani@gmail.com>
 <CAMuHMdV_naTfQOLwOshWq1Q15kSE39a8GWChsjt3RrWRcd6peg@mail.gmail.com>
 <CAJhHMCDaSAzU3zvhY2FRFoBaQH4oQBTsUsYMU6pvBbCXydROZQ@mail.gmail.com>
 <CANq1E4SCnDjN5yetrgtaRNdvDr7xqGOm1BXz7dbGvX3mnsm-MA@mail.gmail.com>
 <54036090.1050104@gmail.com>
 <CANq1E4QbRLjCGr+PuHqKa6Kx_+4MTmbzd9V1RqrQFS3f5YoSag@mail.gmail.com>
 <CAJhHMCBOeLK-Z_96V_aAWBikS6tjrdYfj6_0w-9kSzQb=UJZsw@mail.gmail.com>
 <CANq1E4Sf-XMkODhxEM9Bacr_RBt8p_dHPyeyb7a70_VqrmwXeA@mail.gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 1 Sep 2014 13:16:33 -0400
Message-ID: <CAJhHMCCswNtxZvuD5XdP2vhOykRb4yhkBLbNs02SLWdFLyw0Kg@mail.gmail.com>
Subject: Re: [RFC PATCH] powerpc: Wire up three syscalls
To: David Herrmann <dh.herrmann@gmail.com>
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

On Mon, Sep 1, 2014 at 11:31 AM, David Herrmann <dh.herrmann@gmail.com> wrote:

>
> Btw., the original patch (wire up syscalls) can be applied unchanged.
>

Great! Can I use that as an Ack-by? I will send in the patch with
updated changelog.


-- 
Pranith
