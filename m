Return-Path: <jwboyer@gmail.com>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 86483B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 21:42:12 +1000 (EST)
Received: by qcha6 with SMTP id a6so93014qch.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2012 04:42:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+5PVA64YFcVrjwedn2V2pC8P87DXC1SEgbua+ZHF3VQr=FDmA@mail.gmail.com>
References: <CA+5PVA64YFcVrjwedn2V2pC8P87DXC1SEgbua+ZHF3VQr=FDmA@mail.gmail.com>
Date: Wed, 9 May 2012 07:42:09 -0400
Message-ID: <CA+5PVA6BT8vu6cjuXSn_QvGzDSD96r-4+ekkb-ecFmVRM9t4rA@mail.gmail.com>
Subject: Re: Please pull 'next' branch of 4xx tree
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 2, 2012 at 9:51 AM, Josh Boyer <jwboyer@gmail.com> wrote:
> Hi Ben,
>
> A few patches from Suzie for 47x kexec/kdump support, and some MSI patche=
s
> from Mai La.
>
> josh
>
> The following changes since commit ec34a6814988f17506733c1e8b058ce4660259=
1d:
>
> =A0powerpc: Remove old powerpc specific ptrace getregs/setregs calls
> (2012-04-30 15:37:28 +1000)
>
> are available in the git repository at:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git =
next

Bump?  There's also one small addition on top to fix a build error with -We=
rror.

josh
