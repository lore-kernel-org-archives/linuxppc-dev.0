Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 456A11A056E
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Nov 2014 04:04:12 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1Xkc5x-000dar-4p
 for linuxppc-dev@lists.ozlabs.org; Sat, 01 Nov 2014 17:04:09 +0000
Message-ID: <54551242.2020604@roeck-us.net>
Date: Sat, 01 Nov 2014 10:02:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 33/44] avr32: atngw100: Register with kernel poweroff
 handler
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-34-git-send-email-linux@roeck-us.net>
 <20141101101637.GA5765@samfundet.no>
In-Reply-To: <20141101101637.GA5765@samfundet.no>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, devel@driverdev.osuosl.org,
 linux-s390@vger.kernel.org, lguest@lists.ozlabs.org,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 devicetree@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 linux-pm@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
 linux-tegra@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/01/2014 03:16 AM, Hans-Christian Egtvedt wrote:
> Around Mon 06 Oct 2014 22:28:35 -0700 or thereabout, Guenter Roeck wrote:
>> Register with kernel poweroff handler instead of setting pm_power_off
>> directly.
>>
>> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
>> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>

Thanks!

Guenter
