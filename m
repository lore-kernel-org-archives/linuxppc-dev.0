Return-Path: <linuxdev.baldrick@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdLv60S6xzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 17:59:46 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id f6so9320678ith.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 00:59:45 -0700 (PDT)
MIME-Version: 1.0
From: David Binderman <linuxdev.baldrick@gmail.com>
Date: Mon, 27 Jun 2016 08:59:42 +0100
Message-ID: <CAMzoamZPL6ZPFq_DA2T2sk=LE+ax3OMP7BgcyjiXz82ro8dMWQ@mail.gmail.com>
Subject: arch/powerpc/platforms/512x/clock-commonclk.c:824: wrong % specifier ?
To: agust@denx.de, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dcb314@hotmail.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello there,

linux-4.7-rc5/arch/powerpc/platforms/512x/clock-commonclk.c:824]:
(warning) %d in format string (no. 1) requires 'int' but the argument
type is 'size_t {aka unsigned long}'.

Source code is

        snprintf(name, sizeof(name), "psc%d", mclk_idx);


Regards

David Binderman
