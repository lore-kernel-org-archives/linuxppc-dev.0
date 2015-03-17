Return-Path: <bobby.prani@gmail.com>
Received: from mail-vc0-x22f.google.com (mail-vc0-x22f.google.com
 [IPv6:2607:f8b0:400c:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A77B1A0198
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 14:12:42 +1100 (AEDT)
Received: by mail-vc0-f175.google.com with SMTP id hq11so13768774vcb.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 20:12:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55079859.1020205@hurleysoftware.com>
References: <CAJhHMCC+BJWBo3=XbLf2L_kpOTqR==ee667+TpnFdk3DRT3o+Q@mail.gmail.com>
 <CAJhHMCBcyVbNRQSpsyVfk8HMzZ=NXKkknjDRuch+e+yJGB3T5Q@mail.gmail.com>
 <1426493810.4716.0.camel@ellerman.id.au>
 <CAJhHMCC06H-BRFBBcD_PfumyvHoFAjbi_MOn7gSeq5y093FSEQ@mail.gmail.com>
 <1426548151.31646.4.camel@ellerman.id.au>
 <CAJhHMCDCoo7g5WrXKPEbemoChQn6BGZOXD00z4kZqVE5boEBhA@mail.gmail.com>
 <55079859.1020205@hurleysoftware.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 16 Mar 2015 23:12:08 -0400
Message-ID: <CAJhHMCBzFfKxubMLkrSwCwqs5q494-kD2=a_n+tGHXAp6qgXDg@mail.gmail.com>
Subject: Re: linux panic on 4.0.0-rc4
To: Peter Hurley <peter@hurleysoftware.com>
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

On Mon, Mar 16, 2015 at 10:58 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>> What is your init?
>>
>> I am using systemd from debian unstable.
>
> Do you have a stdout-path property defined in your dts to a serial
> console you're not actually using?
>

I am using tty0 as my console. From the config which I posted, it has:

CONFIG_CMDLINE="console=ttyS0,9600 console=tty0"

I am not using any device tree file.
-- 
Pranith
