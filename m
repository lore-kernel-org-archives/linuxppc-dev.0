Return-Path: <alexdeucher@gmail.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 574732C0084
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 23:52:28 +1000 (EST)
Received: by mail-pa0-f42.google.com with SMTP id lj1so1659113pab.15
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Aug 2013 06:52:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.SOC.1.00.1308031534390.1352@math.ut.ee>
References: <alpine.SOC.1.00.1308031534390.1352@math.ut.ee>
Date: Sat, 3 Aug 2013 09:52:24 -0400
Message-ID: <CADnq5_MzA_oUttcygUswHt7ztwZ2yq62rwx-HS632CwpsGuVjw@mail.gmail.com>
Subject: Re: 3.11-rc3+git: __divdi3 undefined on powerpc (from radeon)
From: Alex Deucher <alexdeucher@gmail.com>
To: Meelis Roos <mroos@linux.ee>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 3, 2013 at 8:44 AM, Meelis Roos <mroos@linux.ee> wrote:
> While trying to compile v3.11-rc3-288-gabe0308 on powerpc 32-bit,
> it failed with the following linking error:
>
> ERROR: "__divdi3" [drivers/gpu/drm/radeon/radeon.ko] undefined!
>
> Some new 64-bit division in radeon that is not implemented on 32-bit
> powerpc?
>
> This is new - 3.11-rc3 worked fine.

Fix is already queued:
http://lists.freedesktop.org/archives/dri-devel/2013-August/042668.html

Alex

>
> --
> Meelis Roos (mroos@linux.ee)
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
