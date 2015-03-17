Return-Path: <bobby.prani@gmail.com>
Received: from mail-vc0-x22f.google.com (mail-vc0-x22f.google.com
 [IPv6:2607:f8b0:400c:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FCD91A0A06
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 13:03:08 +1100 (AEDT)
Received: by mail-vc0-f175.google.com with SMTP id hq11so13683019vcb.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 19:03:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1426548151.31646.4.camel@ellerman.id.au>
References: <CAJhHMCC+BJWBo3=XbLf2L_kpOTqR==ee667+TpnFdk3DRT3o+Q@mail.gmail.com>
 <CAJhHMCBcyVbNRQSpsyVfk8HMzZ=NXKkknjDRuch+e+yJGB3T5Q@mail.gmail.com>
 <1426493810.4716.0.camel@ellerman.id.au>
 <CAJhHMCC06H-BRFBBcD_PfumyvHoFAjbi_MOn7gSeq5y093FSEQ@mail.gmail.com>
 <1426548151.31646.4.camel@ellerman.id.au>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 16 Mar 2015 22:02:34 -0400
Message-ID: <CAJhHMCDCoo7g5WrXKPEbemoChQn6BGZOXD00z4kZqVE5boEBhA@mail.gmail.com>
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

On Mon, Mar 16, 2015 at 7:22 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> The log shows that init is being killed, that's what's causing the panic.
>
> The exitcode of init is 0x200, which due to the vagaries of UNIX is I think an
> "exit status" of 2 in the common usage.
>
> But it suggests that your init is just exiting for some reason?
>

Yeah, seems like that. Not sure why though. git bisect seems to be the
only option.

> What is your init?

I am using systemd from debian unstable.

-- 
Pranith
