Return-Path: <bhsharma@redhat.com>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJLWc3f0qzDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 23:44:44 +1100 (AEDT)
Received: by mail-oi0-f51.google.com with SMTP id w204so81180793oiw.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2017 04:44:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJQMVJVAVQOk1zS+jRLy641fwE0NKnAme2mGbm6Y1_xeA@mail.gmail.com>
References: <1486098682-30395-1-git-send-email-bhsharma@redhat.com>
 <CAGXu5jJQMVJVAVQOk1zS+jRLy641fwE0NKnAme2mGbm6Y1_xeA@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 8 Feb 2017 18:14:42 +0530
Message-ID: <CACi5LpOv7fJE_xcPZsB1es0FtfxCGDw0Av3TK0Q5rC3nLmiTEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] powerpc: mm: support ARCH_MMAP_RND_BITS
To: Kees Cook <keescook@chromium.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
 Daniel Cashman <dcashman@google.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Bhupesh SHARMA <bhupesh.linux@gmail.com>,
 Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anatolij Gustschin <agust@denx.de>,
 Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>,
 Vitaly Bordug <vitb@kernel.crashing.org>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>, Daniel Cashman <dcashman@android.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 4, 2017 at 6:13 AM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Feb 2, 2017 at 9:11 PM, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>> powerpc: arch_mmap_rnd() uses hard-coded values, (23-PAGE_SHIFT) for
>> 32-bit and (30-PAGE_SHIFT) for 64-bit, to generate the random offset
>> for the mmap base address.
>>
>> This value represents a compromise between increased
>> ASLR effectiveness and avoiding address-space fragmentation.
>> Replace it with a Kconfig option, which is sensibly bounded, so that
>> platform developers may choose where to place this compromise.
>> Keep default values as new minimums.
>>
>> This patch makes sure that now powerpc mmap arch_mmap_rnd() approach
>> is similar to other ARCHs like x86, arm64 and arm.
>>
>> Cc: Alexander Graf <agraf@suse.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Anatolij Gustschin <agust@denx.de>
>> Cc: Alistair Popple <alistair@popple.id.au>
>> Cc: Matt Porter <mporter@kernel.crashing.org>
>> Cc: Vitaly Bordug <vitb@kernel.crashing.org>
>> Cc: Scott Wood <oss@buserror.net>
>> Cc: Kumar Gala <galak@kernel.crashing.org>
>> Cc: Daniel Cashman <dcashman@android.com>
>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>> Reviewed-by: Kees Cook <keescook at chromium.org>
>
> This " at " should be "@", but otherwise, yay v2! :)
>

Noted. Sorry for the typo :(

Regards,
Bhupesh
