Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 900C1B73DD
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2011 01:11:05 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] uio: Support 36-bit physical addresses on 32-bit systems
Date: Thu, 13 Oct 2011 14:10:59 +0000
Message-ID: <CAOZdJXVLhe3aNM669sRFmDpHGCVRrP_93xdDwsY9R2VzHUZ-eQ@mail.gmail.com>
References: <1318430145-19898-1-git-send-email-galak@kernel.crashing.org>
 <20111012153229.GB21852@local>
 <AD39F4F8-E9C0-4090-9AEA-644F82DD328B@kernel.crashing.org>
 <CAMuHMdU1rHDvZEknNqKLHyBmJ26kH7SJtxsOZmOysrSzg6bz4g@mail.gmail.com>
In-Reply-To: <CAMuHMdU1rHDvZEknNqKLHyBmJ26kH7SJtxsOZmOysrSzg6bz4g@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "gregkh@suse.de" <gregkh@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Hans J. Koch" <hjk@hansjkoch.de>, Jiang Kai-B18973 <B18973@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 12, 2011 at 11:15 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
>> Do we believe phys_addr_t is always greater than or equal to size need f=
or logical & virtual addresses?
>
> Yes:
>
> #ifdef CONFIG_PHYS_ADDR_T_64BIT
> typedef u64 phys_addr_t;
> #else
> typedef u32 phys_addr_t;
> #endif

This isn't really an answer to the question.  This just says that
phys_addr_t can be 64-bit.  I don't see anywhere in the kernel that we
*enforce* or *require* that sizeof(phys_addr_t) >=3D sizeof(void *).

--=20
Timur Tabi
Linux kernel developer at Freescale=
