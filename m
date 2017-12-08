Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x230.google.com (mail-ua0-x230.google.com
 [IPv6:2607:f8b0:400c:c08::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytJ2X5YJczDwNT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 14:37:38 +1100 (AEDT)
Received: by mail-ua0-x230.google.com with SMTP id i4so6728440uab.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Dec 2017 19:37:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171207110134.22566-1-colin.king@canonical.com>
References: <20171207110134.22566-1-colin.king@canonical.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 8 Dec 2017 14:37:35 +1100
Message-ID: <CAKTCnzmNKtg1morOPS7D3iGHFxZxd1uioex1eGtChBVppcctKA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/xmon: use ARRAY_SIZE on various array sizing
 calculations
To: Colin King <colin.king@canonical.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, kernel-janitors@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 7, 2017 at 10:01 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Use the ARRAY_SIZE macro on several arrays to determine their size.
> Improvement suggested by coccinelle.
>

This file is taken from binutils and re-licensed. Keeping the file
as-is helps apply newer patches easily on top as opposed to redoing
the changes. I would prefer not to move to ARRAY_SIZE and stick to
what's already in the file.

Balbir Singh.
