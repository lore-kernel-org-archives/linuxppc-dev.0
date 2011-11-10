Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BF442100844
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 04:30:58 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH 15/30] powerpc/85xx: Rework P1022DS device tree
Date: Thu, 10 Nov 2011 17:30:50 +0000
Message-ID: <CAOZdJXXh571mgF2rFWqfWOVDBLyS10TdKt9Gk86FhwObaiXjOw@mail.gmail.com>
References: <1320941653-29797-1-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-2-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-3-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-4-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-5-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-6-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-7-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-8-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-9-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-10-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-11-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-12-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-13-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-14-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-15-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-16-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941653-29797-16-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 10, 2011 at 10:13 AM, Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>
> =A0arch/powerpc/boot/dts/fsl/p1022si-post.dtsi | =A0235 +++++++++++++++
> =A0arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi =A0| =A0 68 +++++
> =A0arch/powerpc/boot/dts/p1022ds.dts =A0 =A0 =A0 =A0 =A0 | =A0431 +------=
--------------------
> =A03 files changed, 318 insertions(+), 416 deletions(-)
> =A0create mode 100644 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
> =A0create mode 100644 arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi

I understand the value of removing duplication of DTS contents, so
that we don't copy-paste the same nodes over and over again, but now
that you've added pre- and post- dtsi files, I wonder if you're not
jumping out of the frying pan and into the flame.  It seems that the
DTS files are more fragile than ever, and it's more difficult now to
figure out which files go where.

Another concern I have is whether this will force all Pxxxx boards to
have the same CCSR address.  I don't think so, because I didn't see
it, but I just want to make sure.

--=20
Timur Tabi
Linux kernel developer at Freescale=
