Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wi0-x230.google.com (mail-wi0-x230.google.com
 [IPv6:2a00:1450:400c:c05::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2C32F2C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Mar 2014 20:19:15 +1100 (EST)
Received: by mail-wi0-f176.google.com with SMTP id hi5so1624509wib.9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Mar 2014 01:19:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1393247012.28803.7.camel@smile.fi.intel.com>
References: <1393240172-18769-1-git-send-email-a13xp0p0v88@gmail.com>
 <1393240172-18769-3-git-send-email-a13xp0p0v88@gmail.com>
 <1393247012.28803.7.camel@smile.fi.intel.com>
Date: Sat, 1 Mar 2014 13:19:08 +0400
Message-ID: <CAF0T0X7RXQzb38SHfYsW33Kz-WUX5KE+khDX6pkhBC5ftuewXg@mail.gmail.com>
Subject: Re: [PATCH RFC v8 2/5] dma: mpc512x: add support for peripheral
 transfers
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, Gerhard Sittig <gsi@denx.de>,
 Alexander Popov <a13xp0p0v88@gmail.com>, dmaengine@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Andy.

2014-02-24 17:03 GMT+04:00 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> On Mon, 2014-02-24 at 15:09 +0400, Alexander Popov wrote:
>> Introduce support for slave s/g transfer preparation and the associated
>> device control callback in the MPC512x DMA controller driver, which adds
>> support for data transfers between memory and peripheral I/O to the
>> previously supported mem-to-mem transfers.
>>
>
> Few comments below.

Thanks for your feedback. I agree with your points and will fix my code.

Best regards,
Alexander
