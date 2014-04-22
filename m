Return-Path: <linus.walleij@linaro.org>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
 [209.85.214.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1035F14008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 23:03:30 +1000 (EST)
Received: by mail-ob0-f174.google.com with SMTP id gq1so5665967obb.33
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 06:03:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1397281291-28694-1-git-send-email-shc_work@mail.ru>
References: <1397281291-28694-1-git-send-email-shc_work@mail.ru>
Date: Tue, 22 Apr 2014 15:03:26 +0200
Message-ID: <CACRpkdZAkNtUqAcQw78wCTzV8JKj1465aY1KW+8dqO4tWT6qZw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: ge: Convert to platform driver
From: Linus Walleij <linus.walleij@linaro.org>
To: Alexander Shiyan <shc_work@mail.ru>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Martyn Welch <martyn.welch@gefanuc.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Alexandre Courbot <gnurou@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Apr 12, 2014 at 7:41 AM, Alexander Shiyan <shc_work@mail.ru> wrote:

> This patch converts GE I/O FPGA GPIO driver to platform driver.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

No further comments, so this v2 patch is applied.

Yours,
Linus Walleij
