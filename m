Return-Path: <catalin.marinas@gmail.com>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D7832C0160
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 23:29:22 +1000 (EST)
Received: by mail-pd0-f177.google.com with SMTP id g10so2346368pdj.36
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 06:29:21 -0700 (PDT)
MIME-Version: 1.0
Sender: catalin.marinas@gmail.com
In-Reply-To: <90a2283bb84b6ce77c9966d76dbceb5c7edffd18.1368702323.git.mst@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
 <90a2283bb84b6ce77c9966d76dbceb5c7edffd18.1368702323.git.mst@redhat.com>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 16 May 2013 14:29:01 +0100
Message-ID: <CAHkRjk5bHV3WDSnfQLr1MPTXGXXKP+XKRbqL2fn_bPmXt_7=cw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] arm64: uaccess s/might_sleep/might_fault/
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-m32r-ja@ml.linux-m32r.org,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 David Howells <dhowells@redhat.com>, linux-mm <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 linux-am33-list@redhat.com, Hirokazu Takata <takata@linux-m32r.org>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 microblaze-uclinux@itee.uq.edu.au, Chris Metcalf <cmetcalf@tilera.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, linux-m32r@ml.linux-m32r.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16 May 2013 12:10, Michael S. Tsirkin <mst@redhat.com> wrote:
> The only reason uaccess routines might sleep
> is if they fault. Make this explicit.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/arm64/include/asm/uaccess.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
