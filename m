Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-io0-x22d.google.com (mail-io0-x22d.google.com
 [IPv6:2607:f8b0:4001:c06::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkDJW0z0BzDqZ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 19:21:31 +1000 (AEST)
Received: by mail-io0-x22d.google.com with SMTP id b2so13247167iof.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Sep 2017 02:21:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170901072744.2409-1-dja@axtens.net>
References: <20170901072744.2409-1-dja@axtens.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 1 Sep 2017 10:21:28 +0100
Message-ID: <CAKv+Gu84njSF5uOvNtknGdOd5auU7zw9scFeTq5v-=OhExgOqA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Split default display handling out from VGA arbiter
To: Daniel Axtens <dja@axtens.net>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>,
 Zou Rongrong <zourongrong@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Bjorn Helgaas <helgaas@kernel.org>,
 David Airlie <airlied@linux.ie>, "Vetter, Daniel" <daniel.vetter@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Lukas Wunner <lukas@wunner.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1 September 2017 at 08:27, Daniel Axtens <dja@axtens.net> wrote:
> This patch set:
>
>  - splits the default display handling out from VGA arbiter, into its
>    own file and behind its own Kconfig option (and gives the functions
>    better names).
>
>  - adds extra detection of default devices. To be nominated, the vga
>    arbiter and platform hooks must not have nominated a default. A
>    card will then only be nominated if it has a driver attached and
>    has IO or memory decoding enabled.
>
>  - adds relevant documentation.
>
> The practical impact of this is improved X autoconfiguration on some
> arm64 systems.
>
> Changes in v3:
>
>  - Add documentation - thanks Daniel Vetter for pointing it out.
>
>  - Clarify explanations. Thanks to everyone for continuing to bear
>    with my incomplete understanding of PCI and provide some clarity.
>
>  - Split refactoring and adding functionality.
>
> Changes in v2: https://www.spinics.net/lists/linux-pci/msg64007.html
>
> Drop all the powerpc patches. [explanation snipped]
>
> v1: https://www.spinics.net/lists/linux-pci/msg63581.html
>

If we are all in agreement that fixing X is not an option, I think
this is a reasonable approach

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
