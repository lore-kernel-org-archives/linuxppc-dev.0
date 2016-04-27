Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwFsr2pb1zDqB3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 09:05:03 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-arch@vger.kernel.org, a.zummo@towertech.it, dalias@libc.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, deller@gmx.de,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
 linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org,
 rtc-linux@googlegroups.com
Subject: Re: [PATCH v3 09/16] rtc: m68k: provide rtc_class_ops directly
Date: Thu, 28 Apr 2016 01:04:23 +0200
Message-ID: <4642144.cyaFZ6JYuF@wuerfel>
In-Reply-To: <1461796470-1291527-10-git-send-email-arnd@arndb.de>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
 <1461796470-1291527-10-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 28 April 2016 00:34:23 Arnd Bergmann wrote:
>                 return -ENODEV;
>  
> -       pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
> +       /* or just call devm_rtc_device_register instead? */

Oops, I was planning to remove the comment here.

I probably have to do a v4 anyway, fixed it up locally now.

	Arnd
