Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdV396N6nzF0gL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 09:24:05 +1100 (AEDT)
Received: from mail-qk0-f169.google.com (mail-qk0-f169.google.com
 [209.85.220.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D2262217AA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 22:24:03 +0000 (UTC)
Received: by mail-qk0-f169.google.com with SMTP id d72so11904619qkc.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Feb 2018 14:24:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+7wUszna8NoXLvpjJM7piveywBux33qFgA-mkV_yteACHsunw@mail.gmail.com>
References: <CA+7wUszna8NoXLvpjJM7piveywBux33qFgA-mkV_yteACHsunw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 9 Feb 2018 16:23:42 -0600
Message-ID: <CAL_Jsq+FXdbNKSZbVv7LcyEUuWgqn1XpNQ5SFZYqYJTLBE5uJg@mail.gmail.com>
Subject: Re: powerpc/pci: Use of_irq_parse_and_map_pci() helper
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 9, 2018 at 4:01 PM, Mathieu Malaterre <malat@debian.org> wrote:
> Hi Rob,
>
> I can no longer boot my old Mac Mini G4 using a custom config. After a
> tedious bisect it appears that (*). Since Mac Mini does not provide
> any serial port I cannot provide a kernel message dump (wish there was
> some kind of null modem serial cable). All I can see is some crazy
> stuff going on with ATA DMA/66 & DMA/100.
>
> Is there anything suspicious in this commit which may prevent this
> machine to boot ?

Yes, it's broken. You need this patch[1]. Sorry for the breakage.

Rob

[1] https://patchwork.kernel.org/patch/10208267/
