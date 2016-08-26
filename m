Return-Path: <LW@KARO-electronics.de>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
 [81.173.242.67]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sLBQ01NGqzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 16:45:43 +1000 (AEST)
Date: Fri, 26 Aug 2016 08:27:20 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 legousb-devel@lists.sourceforge.net,
 accessrunner-general@lists.sourceforge.net, linux-tegra@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/44] usb: don't print on ENOMEM
Message-ID: <20160826082720.39f1e394@ipc1.ka-ro>
In-Reply-To: <20160825173947.26624-1-wsa-dev@sang-engineering.com>
References: <20160825173947.26624-1-wsa-dev@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Thu, 25 Aug 2016 19:38:52 +0200 Wolfram Sang wrote:
> Here is my next series to save memory by removing unneeded strings. It re=
moves
> in the usb subsystem all unspecific error messages after calling malloc-b=
ased
> functions, i.e. (devm_)k[zcm]alloc. kmalloc prints enough information in =
that
> case. If the message was specific (e.g. "can't save CLEAR_TT_BUFFER state=
"), I
> left it. This series saves ~4.5KB of "out of memory" permutations in .tex=
t and
> .rodata. For modified lines, (x =3D=3D NULL) was replaced with (!NULL) as=
 well.
s/!NULL/!x/


Lothar Wa=C3=9Fmann
