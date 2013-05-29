Return-Path: <B41889@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B3DE2C0209
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 19:31:02 +1000 (EST)
Message-ID: <51A5CAC1.6030800@freescale.com>
Date: Wed, 29 May 2013 17:30:41 +0800
From: Chen Yuanquan-B41889 <B41889@freescale.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] powerpc/pci: Improve device hotplug initialization
References: <1369762514-27352-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1369762514-27352-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Yuanquan Chen <Yuanquan.Chen@freescale.com>,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/29/2013 01:35 AM, Guenter Roeck wrote:
> bios_add_device(). Drop explicit calls to pcibios_setup_device();
> this makes pcibios_setup_bus_devices() a noop function which could
> eve

Yeah, it's more reasonable to do the irq and DMA related initialization
in one code path for all devices.

Regards,
Yuanquan
