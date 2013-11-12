Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 36D722C0091
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Nov 2013 07:20:47 +1100 (EST)
Received: from mail-ve0-f174.google.com (mail-ve0-f174.google.com
 [209.85.128.174])
 by muin.pair.com (Postfix) with ESMTPSA id 58E6C8FC31
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Nov 2013 15:13:20 -0500 (EST)
Received: by mail-ve0-f174.google.com with SMTP id cz12so2590540veb.5
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Nov 2013 12:13:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1384197913-24610-1-git-send-email-Lijun.Pan@freescale.com>
References: <1383952632-5770-1-git-send-email-Lijun.Pan@freescale.com>
 <1384197913-24610-1-git-send-email-Lijun.Pan@freescale.com>
Date: Tue, 12 Nov 2013 14:13:19 -0600
Message-ID: <CAOZdJXWse3EbWVzu_1fLq5+B5Zd9n1_UVF11Zj2MBcsH0Dm0Dw@mail.gmail.com>
Subject: Re: [PATCH V2] powerpc/85xx: Merge 85xx/p1023_defconfig into
 mpc85xx_smp_defconfig and mpc85xx_defconfig
From: Timur Tabi <timur@tabi.org>
To: Lijun Pan <Lijun.Pan@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 11, 2013 at 1:25 PM, Lijun Pan <Lijun.Pan@freescale.com> wrote:
> +CONFIG_P1023_RDB=y

I think this is the only line you should be adding to the defconfigs.
None of the others should be necessary.
