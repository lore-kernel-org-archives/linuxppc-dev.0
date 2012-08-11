Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E12C32C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2012 23:07:24 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] powerpc/epapr: export epapr_hypercall_start
Date: Sat, 11 Aug 2012 13:07:14 +0000
Message-ID: <CAOZdJXW+Br2LCxCuMruHJtODqu+8xcdgWrcLPWE2aJ2U23RU3g@mail.gmail.com>
References: <20120810222121.GA9408@tyr.buserror.net>
 <CAMuHMdUZmT3g1+6yBPK3LAjTO-orE3Fh7QUP7AB5Kj8o4M4_1g@mail.gmail.com>
In-Reply-To: <CAMuHMdUZmT3g1+6yBPK3LAjTO-orE3Fh7QUP7AB5Kj8o4M4_1g@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 11, 2012 at 2:01 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sat, Aug 11, 2012 at 12:21 AM, Scott Wood <scottwood@freescale.com> wr=
ote:
>> +EXPORT_SYMBOL(epapr_hypercall_start);
>
> EXPORT_SYMBOL_GPL?

We prefer EXPORT_SYMBOL.  We don't want to restrict our customers from
having to use GPL code.

--=20
Timur Tabi
Linux kernel developer at Freescale=
