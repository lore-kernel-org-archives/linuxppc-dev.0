Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDZ4g01r3zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 20:11:46 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id f144so1057612pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Feb 2017 01:11:46 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 2 Feb 2017 14:41:36 +0530
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, kernel-hardening@lists.openwall.com,
 Alistair Popple <alistair@popple.id.au>,
 Anatolij Gustschin <agust@denx.de>, keescook@chromium.org,
 Daniel Cashman <dcashman@android.com>,
 Scott Wood <oss@buserror.net>, Paul Mackerras <paulus@samba.org>,
 dcashman@google.com, bhupesh.linux@gmail.com,
 Alexander Graf <agraf@suse.com>
Subject: Re: [PATCH 1/2] powerpc: mm: support ARCH_MMAP_RND_BITS
Message-ID: <20170202091136.GC5179@localhost.localdomain>
References: <1486014168-1279-1-git-send-email-bhsharma@redhat.com>
 <1486014168-1279-2-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486014168-1279-2-git-send-email-bhsharma@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> @@ -100,6 +132,8 @@ config PPC
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
>  	select HAVE_KPROBES
>  	select HAVE_ARCH_KGDB
> +	select HAVE_ARCH_MMAP_RND_BITS
> +	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT

COMPAT is on for ppc64 by default, so we'll end up with COMPAT_BITS same
as before all the time.

Balbir Singh.
