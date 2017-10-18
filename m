Return-Path: <dja@axtens.net>
Received: from mail-pf0-x22e.google.com (mail-pf0-x22e.google.com
 [IPv6:2607:f8b0:400e:c00::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yH8PT6LzpzDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 22:06:05 +1100 (AEDT)
Received: by mail-pf0-x22e.google.com with SMTP id e64so3701274pfk.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 04:06:05 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-pci@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 Xinliang Liu <z.liuxinliang@hisilicon.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Rongrong Zou <zourongrong@gmail.com>, Dave Airlie <airlied@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] vgaarb: Factor out EFI and fallback default device
 selection
In-Reply-To: <20171018081822.pqmkj2xfgg6kb6xa@phenom.ffwll.local>
References: <20171013034338.14630.4766.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171013034729.14630.30419.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <871sm2y1h9.fsf@linkitivity.dja.id.au>
 <20171017120506.ervbnyjue55zn67b@phenom.ffwll.local>
 <878tg9i9pw.fsf@linkitivity.dja.id.au>
 <20171018081822.pqmkj2xfgg6kb6xa@phenom.ffwll.local>
Date: Wed, 18 Oct 2017 22:05:57 +1100
Message-ID: <8760bciulm.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Daniel Vetter <daniel@ffwll.ch> writes:

> On Wed, Oct 18, 2017 at 11:24:43AM +1100, Daniel Axtens wrote:
>> Hi Daniel,
>> 
>> >> Initially I wondered if this info printk could be moved into
>> >> vga_arbiter_check_bridge_sharing(), but it's been separated out since
>> >> 3448a19da479b ("vgaarb: use bridges to control VGA routing where
>> >> possible."), and upon closer examination, it seems you can't be sure a
>> >> device doesn't share a bridge until the end of the process, so this is
>> >> indeed correct.
>> >> 
>> >> Everything else also looks good to me.
>> >> 
>> >> Reviewed-by: Daniel Axtens <dja@axtens.net>
>> >
>> > R-b for both patches? And ok with everyone if I pull this into drm-misc
>> > for 4.15 (deadline is end of this week for feature-y stuff)?
>> 
>> I had only intended it for patch 2, but I've now read over patch 1 to my
>> satisfaction, so it too is:
>> 
>> Reviewed-by: Daniel Axtens <dja@axtens.net>
>
> Both applied for 4.15, thanks.

Cool - thanks!

A special thanks to Bjorn for persisting with this and coming up with a
nice simple solution :)

Regards,
Daniel

> -Daniel
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
