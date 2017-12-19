Return-Path: <tcminyard@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1SZJ5PlKzDrWl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 06:26:32 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id s9so13123093oie.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 11:26:32 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
Subject: Re: [-next PATCH 0/4] sysfs and DEVICE_ATTR_<foo>
To: Joe Perches <joe@perches.com>, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 intel-gfx@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, linux-s390@vger.kernel.org,
 esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org
References: <cover.1513706701.git.joe@perches.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <09832872-8e6c-3327-6e28-7ee6cc48df04@acm.org>
Date: Tue, 19 Dec 2017 13:26:26 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1513706701.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/19/2017 12:15 PM, Joe Perches wrote:
>   drivers/char/ipmi/ipmi_msghandler.c                | 17 +++---

For ipmi:

Acked-by: Corey Minyard <cminyard@mvista.com>
