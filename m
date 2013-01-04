Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D99812C007C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2013 21:50:10 +1100 (EST)
Date: Fri, 4 Jan 2013 11:49:47 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Johannes Braun <jjo.braun@gmail.com>
Subject: Re: tqm5200s i2c bus timeout
Message-ID: <20130104114947.0f350bd4@crub>
In-Reply-To: <CADwvPCuw7p+O6bXtAoR=6yK9UgBR4JV58f+4s42KMDsvQ-dB6w@mail.gmail.com>
References: <CADwvPCve5GaRZZXuLUq4Es2FLN8AxtbRP4TQP7gQVRXoMw3S0g@mail.gmail.com>
 <20130103151106.04e1ae94@crub>
 <CADwvPCuw7p+O6bXtAoR=6yK9UgBR4JV58f+4s42KMDsvQ-dB6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 4 Jan 2013 08:50:03 +0100
Johannes Braun <jjo.braun@gmail.com> wrote:
...
> The good thing is that I can see all the devices now. Also the driver
> for the rtc clock is loading. But the time can`t be read through the
> registered rtc0 device. This is the kernel log. But I think this is a
> driver issue and I should have a look inside the driver.
> 
> [    1.483761] rtc-pcf8563 1-0051: chip found, driver version 0.4.3
> [    1.490382] rtc-pcf8563 1-0051: pcf8563_get_datetime: read error
> [    1.497478] rtc-pcf8563 1-0051: rtc core: registered rtc-pcf8563 as rtc0

The RTC slave address is correct. Is the pcf8563 RTC on I2C2 bus on
your board?

Thanks,
Anatolij
