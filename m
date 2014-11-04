Return-Path: <leif.lindholm@linaro.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71AB01A0315
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Nov 2014 07:19:06 +1100 (AEDT)
Received: by mail-wg0-f51.google.com with SMTP id l18so14313655wgh.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Nov 2014 12:19:03 -0800 (PST)
Date: Tue, 4 Nov 2014 20:18:59 +0000
From: Leif Lindholm <leif.lindholm@linaro.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH] make CONFIG_STRICT_DEVMEM a core non-debug feature
Message-ID: <20141104201859.GZ22224@bivouac.eciton.net>
References: <1415121836-16241-1-git-send-email-leif.lindholm@linaro.org>
 <CAGXu5jL1BBAvoxVqFa1YHJSMCbGdLiPey-dyC15YKVPB2xGfig@mail.gmail.com>
 <20141104195914.GY22224@bivouac.eciton.net>
 <CAGXu5jJnaAFMUBR50TgapRzRcvKS0j=XO7u9z6fdNouwMb=_sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXu5jJnaAFMUBR50TgapRzRcvKS0j=XO7u9z6fdNouwMb=_sQ@mail.gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>,
 paulus@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-s390@vger.kernel.org,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 "x86@kernel.org" <x86@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, dave.long@linaro.org, eiko.carstens@de.ibm.com,
 Arnd Bergmann <arnd@arndb.de>, Chris Metcalf <cmetcalf@tilera.com>,
 Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 04, 2014 at 12:02:32PM -0800, Kees Cook wrote:
> > I considered doing that, but didn't want to risk listing too many
> > details of one architecture, and too few of others.
> 
> Well, the others only say "memory mapped peripherals", so that's what
> I was suggesting adding the x86 language: it was the most detailed
> about what that would really mean to the end-user.

The problem is that this currently isn't strictly speaking true for
some architectures (at least not arm*). Without a standardised memory
map, we are exposing mapping anything not system RAM.

(Patches related to that will follow later this month.)

/
    Leif
