Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHStH5lBQzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 13:27:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bhupesh Sharma <bhsharma@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 kernel-hardening@lists.openwall.com
Cc: dcashman@google.com, bhupesh.linux@gmail.com, keescook@chromium.org,
 Bhupesh Sharma <bhsharma@redhat.com>, Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anatolij Gustschin <agust@denx.de>,
 Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>,
 Vitaly Bordug <vitb@kernel.crashing.org>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>, Daniel Cashman <dcashman@android.com>
Subject: Re: [kernel-hardening] [PATCH v2 1/1] powerpc: mm: support
 ARCH_MMAP_RND_BITS
In-Reply-To: <1486098682-30395-1-git-send-email-bhsharma@redhat.com>
References: <1486098682-30395-1-git-send-email-bhsharma@redhat.com>
Date: Tue, 07 Feb 2017 13:27:51 +1100
Message-ID: <87efzag2fs.fsf@concordia.ellerman.id.au>
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

Bhupesh Sharma <bhsharma@redhat.com> writes:

> powerpc: arch_mmap_rnd() uses hard-coded values, (23-PAGE_SHIFT) for
> 32-bit and (30-PAGE_SHIFT) for 64-bit, to generate the random offset
> for the mmap base address.
>
> This value represents a compromise between increased
> ASLR effectiveness and avoiding address-space fragmentation.
> Replace it with a Kconfig option, which is sensibly bounded, so that
> platform developers may choose where to place this compromise.
> Keep default values as new minimums.
>
> This patch makes sure that now powerpc mmap arch_mmap_rnd() approach
> is similar to other ARCHs like x86, arm64 and arm.
>
> Cc: Alexander Graf <agraf@suse.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: Alistair Popple <alistair@popple.id.au>
> Cc: Matt Porter <mporter@kernel.crashing.org>
> Cc: Vitaly Bordug <vitb@kernel.crashing.org>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: Daniel Cashman <dcashman@android.com>
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> Reviewed-by: Kees Cook <keescook at chromium.org>
> ---
> Changes since v1:
> v1 can be seen here (https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-February/153594.html)
>     - No functional change in this patch.
>     - Added R-B from Kees.
>     - Dropped PATCH 2/2 from v1 as recommended by Kees Cook.

Thanks for v2.

But I replied to your v1 with some comments, did you see them?

cheers
