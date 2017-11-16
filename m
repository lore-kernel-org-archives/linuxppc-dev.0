Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com
 [IPv6:2607:f8b0:400c:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ycnLH0DGxzDqr8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 14:49:26 +1100 (AEDT)
Received: by mail-vk0-x242.google.com with SMTP id p80so1972369vkd.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 19:49:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171025152754.25166-1-gpiccoli@linux.vnet.ibm.com>
References: <20171025152754.25166-1-gpiccoli@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 16 Nov 2017 14:49:23 +1100
Message-ID: <CAKTCnz=yR1Nm1mCzNVVbDkxz=es5H9v-+J-y+8FN5ttB1EZ=Bg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/powernv: Add pci_reset_phbs parameter to issue
 a PHB reset
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 26, 2017 at 2:27 AM, Guilherme G. Piccoli
<gpiccoli@linux.vnet.ibm.com> wrote:
> During a kdump kernel boot in PowerPC, we request a reset of the PHBs
> to the FW. It makes sense, since if we are booting a kdump kernel it
> means we had some trouble before and we cannot rely in the adapters'
> health; they could be in a bad state, hence the reset is needed.
>
> But this reset is useful not only in kdump - there are situations,
> specially when debugging drivers, that we could break an adapter in
> a way it requires such reset. One can tell to just go ahead and
> reboot the machine, but happens that many times doing kexec is much
> faster, and so preferable than a full power cycle.
>
> This patch adds the pci_reset_phbs parameter to perform such reset
> when desired by the user.
>

Do we care to reset specific phbs or all of them? I guess all based on
your description.

Balbir Singh.
